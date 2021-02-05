using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text.RegularExpressions;
using System.Drawing;
using System.Security.Cryptography;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using System.Net;
using System.IO;
using System.Web.Script.Serialization;
using System.Web.Services;


namespace _190526E_AS
{
    public partial class Registration : System.Web.UI.Page
    {
        string MYDBConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["MYDBConnection"].ConnectionString;
        static string finalHash;
        static string salt;
        byte[] Key;
        byte[] IV;

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btn_checkPassword_Click(object sender, EventArgs e)
        {
            // implement codes for the button event
            // Extract data from textbox
            int scores = checkPassword(tb_Password.Text);
            string status = "";
            switch (scores)
            {
                case 1:
                    status = "Very Weak";
                    break;
                case 2:
                    status = "Weak";
                    break;
                case 3:
                    status = "Medium";
                    break;
                case 4:
                    status = "Good";
                    break;
                case 5:
                    status = "Excellent";
                    break;
                default:
                    break;
            }
            lbl_pwdchecker.Text = "Status : " + status;
            if (scores < 4)
            {
                lbl_pwdchecker.ForeColor = Color.Red;
                return;
            }
            lbl_pwdchecker.ForeColor = Color.Green;

        }


        private int checkPassword(string password)
        {
            int score = 0;

            //score 0 very weak!
            //if length of password is less than 8 chars
            if (password.Length < 8)
            {
                return 1;
            }
            else
            {
                score = 1;
            }
            //Score 2 Weak
            if (Regex.IsMatch(password, "[a-z]"))
            {
                score = 2;
            }
            //Score 3 Medium
            if (Regex.IsMatch(password, "[A-Z]"))
            {
                score = 3;
            }
            //Score 4 Strong
            if (Regex.IsMatch(password, "[0-9]"))
            {
                score = 4;
            }
            //Score 5 Excellent
            if (Regex.IsMatch(password, "[!@#$%^&*]"))
            {
                score = 5;
            }

            return score;
        }



            public void createAccount()
            {
                try
                {
                    using (SqlConnection con = new SqlConnection(MYDBConnectionString))
                    {
                    using (SqlCommand cmd = new SqlCommand("INSERT INTO Account VALUES(@FirstName, @LastName, @CreditCardInfo, @EmailAddress, @DateOfBirth, @PasswordHash, @PasswordSalt, @IV, @Key)"))

                    {
                        using (SqlDataAdapter sda = new SqlDataAdapter())
                        {
                            cmd.CommandType = CommandType.Text;
                            cmd.Parameters.AddWithValue("@FirstName", tb_Fname.Text.Trim());
                            cmd.Parameters.AddWithValue("@LastName", tb_Lname.Text.Trim());
                            cmd.Parameters.AddWithValue("@CreditCardInfo", Convert.ToBase64String(encryptData(tb_CCinfo.Text.Trim())));
                            cmd.Parameters.AddWithValue("@EmailAddress", tb_Eaddress.Text.Trim());
                            cmd.Parameters.AddWithValue("@DateOfBirth", tb_Dob.Text.Trim());
                            cmd.Parameters.AddWithValue("@PasswordHash", finalHash); 
                            cmd.Parameters.AddWithValue("@PasswordSalt", salt);
                            cmd.Parameters.AddWithValue("@IV", Convert.ToBase64String(IV));
                            cmd.Parameters.AddWithValue("@Key", Convert.ToBase64String(Key));

                            cmd.Connection = con;
                            con.Open();
                            cmd.ExecuteNonQuery();
                            con.Close();
                        }
                    }
                    }

                }
                catch (Exception ex)
                {
                    throw new Exception(ex.ToString());
                }
            }

            protected byte[] encryptData(string data)
            {
                byte[] cipherText = null;
                try
                {
                    RijndaelManaged cipher = new RijndaelManaged();
                    cipher.IV = IV;
                    cipher.Key = Key;
                    ICryptoTransform encryptTransform = cipher.CreateEncryptor();
                    //ICryptoTransform decryptTransform = cipher.CreateDecryptor();
                    byte[] plainText = Encoding.UTF8.GetBytes(data);
                    cipherText = encryptTransform.TransformFinalBlock(plainText, 0,
                   plainText.Length);
                }
                catch (Exception ex)
                {
                    throw new Exception(ex.ToString());
                }
                finally { }
                return cipherText;
            }

        protected void Button1_Click(object sender, EventArgs e)
        {
            {
                {
                    if (tb_Password.Text.Length > 5 && tb_CCinfo.Text.Length > 2 && tb_Fname.Text.Length > 1 && tb_Lname.Text.Length > 1)
                    {
                        //string pwd = get value from your Textbox
                        string pwd = tb_Password.Text.ToString().Trim(); ;
                        //Generate random "salt"
                        RNGCryptoServiceProvider rng = new RNGCryptoServiceProvider();
                        byte[] saltByte = new byte[8];
                        //Fills array of bytes with a cryptographically strong sequence of random values.
                        rng.GetBytes(saltByte);
                        salt = Convert.ToBase64String(saltByte);
                        SHA512Managed hashing = new SHA512Managed();
                        string pwdWithSalt = pwd + salt;
                        byte[] plainHash = hashing.ComputeHash(Encoding.UTF8.GetBytes(pwd));
                        byte[] hashWithSalt = hashing.ComputeHash(Encoding.UTF8.GetBytes(pwdWithSalt));
                        finalHash = Convert.ToBase64String(hashWithSalt);
                        RijndaelManaged cipher = new RijndaelManaged();
                        cipher.GenerateKey();
                        Key = cipher.Key;
                        IV = cipher.IV;
                        createAccount();
                        Response.Redirect("Login.aspx");
                    }
                    else
                    {
                        lbl_error.Text = "Please enter the fields correctly!";
                        HttpUtility.HtmlEncode(tb_Password);
                    }
                }
            }
        }

        public class MyObject
        {
            public string success { get; set; }
            public List<string> ErrorMessage { get; set; }

        }

        public bool ValidateCaptcha()
        {
            bool result = true;
            string captchaResponse = Request.Form["g-recaptcha-response"];

            HttpWebRequest req = (HttpWebRequest)WebRequest.Create
            ("http://www.google.com/recaptcha/api/siteverify?secret=6LdamUkaAAAAAEJgpCOih2pg8BTxgFAWxRhiGTIM) &response=" + captchaResponse);

            try
            {
                using (WebResponse wResponse = req.GetResponse())
                {
                    using (StreamReader readStream = new StreamReader(wResponse.GetResponseStream()))
                    {
                        string jsonResponse = readStream.ReadToEnd();
                        lbl_error.Text = jsonResponse.ToString();
                        JavaScriptSerializer js = new JavaScriptSerializer();
                        MyObject jsonObject = js.Deserialize<MyObject>(jsonResponse);
                        result = Convert.ToBoolean(jsonObject.success);
                    }
                    return result;
                }
            }
            catch (WebException ex)
            {
                throw ex;
            }

        }



}
    
}
