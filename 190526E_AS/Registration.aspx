<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Registration.aspx.cs" Inherits="_190526E_AS.Registration" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Registration Form</title>
    <script src ="https://www.google.com/recaptcha/api.js?render=6LdamUkaAAAAAO5rQOPzF4I0pEIkhRWicey0DHdP"></script>
    <script type ="text/javascript">
        function validate() {
            var str = document.getElementById('<%=tb_Password.ClientID %>').value;

            if (str.length < 8) {
                document.getElementById("lbl_pwdchecker").innerHTML = "Password Length Must be at Least 8 Characters";
                document.getElementById("lbl_pwdchecker").style.color = "Red";
                return ("too_short")
            }

            else if (str.search(/[0-9]/) == -1) {
                document.getElementById("lbl_pwdchecker").innerHTML = "Password require at least 1 number";
                document.getElementById("lbl_pwdchecker").style.color = "Red";
                return ("no_number");
            }

            else if (str.search(/[A-Z]/) == -1) {
                document.getElementById("lbl_pwdchecker").innerHTML = "Password require at least 1 uppercase";
                document.getElementById("lbl_pwdchecker").style.color = "Red";
                return ("no_uppercase");
            }

            else if (str.search(/[a-z]/) == -1) {
                document.getElementById("lbl_pwdchecker").innerHTML = "Password require at least 1 lowercase";
                document.getElementById("lbl_pwdchecker").style.color = "Red";
                return ("no_lowercase");
            }

            else if (str.search(/[!@#$%^&*]/) == -1) {
                document.getElementById("lbl_pwdchecker").innerHTML = "Password require at least 1 symbol";
                document.getElementById("lbl_pwdchecker").style.color = "Red";
                return ("no_symbol");
            }

            document.getElementById("lbl_pwdchecker").innerHTML = "Good Password"
            document.getElementById("lbl_pwdchecker").style.color = "Green";
        }
    </script>

    <style type="text/css">
        .auto-style1 {
            margin-bottom: 0px;
        }
        .auto-style2 {
            width: 100%;
        }
        .auto-style4 {
            width: 141px;
        }
        .auto-style5 {
            margin-left: 0px;
        }
        .auto-style6 {
            width: 144px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            Registration Form<table class="auto-style2">
                <tr>
                    <td class="auto-style6">
            <asp:Label ID="lbl_Fname" runat="server" Text="First Name"></asp:Label>
                    </td>
                    <td class="auto-style4">
            <asp:TextBox ID="tb_Fname" runat="server"></asp:TextBox>
                    </td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style6">
            <asp:Label ID="lbl_Lname" runat="server" Text="Last Name"></asp:Label>
                    </td>
                    <td class="auto-style4">
            <asp:TextBox ID="tb_Lname" runat="server"></asp:TextBox>
                    </td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style6">
            <asp:Label ID="lbl_CCinfo" runat="server" Text="Credit Card Info"></asp:Label>
                    </td>
                    <td class="auto-style4"><asp:TextBox ID="tb_CCinfo" runat="server"></asp:TextBox>
                    </td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style6">
            <asp:Label ID="lbl_Eaddress" runat="server" Text="Email Address"></asp:Label>
                    </td>
                    <td class="auto-style4">
            <asp:TextBox ID="tb_Eaddress" runat="server" CssClass="auto-style1" TextMode="Email"></asp:TextBox>
                    </td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style6">
            <asp:Label ID="lbl_Password" runat="server" Text="Password"></asp:Label>
                    </td>
                    <td class="auto-style4">
            <asp:TextBox ID="tb_Password" runat="server" onkeyup="javascript:validate()" TextMode="Password"></asp:TextBox>
                    </td>
                    <td>
            <asp:Label ID="lbl_pwdchecker" runat="server" Text="-"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style6">&nbsp;</td>
                    <td class="auto-style4">
            <asp:Button ID="btn_checkPassword" runat="server" OnClick="btn_checkPassword_Click" Text="Check Password" Width="125px" />
                    </td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style6">
            <asp:Label ID="lbl_Dob" runat="server" Text="Date Of Birth"></asp:Label>
                    </td>
                    <td class="auto-style4">
            <asp:TextBox ID="tb_Dob" runat="server" TextMode="Date"></asp:TextBox>
                    </td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style6">&nbsp;</td>
                    <td class="auto-style4">&nbsp;</td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style6">
                        &nbsp;</td>
                    <td class="auto-style4">
                        <input type ="hidden" id ="g-recaptcha-response" name="g-recaptcha-response" />
                        &nbsp;</td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style6">&nbsp;</td>
                    <td class="auto-style4">
            <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Submit" Width="199px" CssClass="auto-style5" />
                    </td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style6">&nbsp;</td>
                    <td class="auto-style4">
                        <asp:Label ID="lbl_error" runat="server" Text="-"></asp:Label>
                    </td>
                    <td>&nbsp;</td>
                </tr>
            </table>
            <br />
            <br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <br />
&nbsp;<br />
&nbsp;&nbsp;&nbsp;
            <br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <br />
&nbsp;&nbsp;&nbsp;&nbsp;
            &nbsp;&nbsp;&nbsp;
            <br />
            <br />
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <br />
        </div>
    </form>
<script>
    grecaptcha.ready(function () {
        grecaptcha.execute('6LdamUkaAAAAAO5rQOPzF4I0pEIkhRWicey0DHdP', { action: 'Login' }).then(function (token) {
        document.getElementById("g-recaptcha-response").value = token;
        });
    });
</script>

</body>
</html>
