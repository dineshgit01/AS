    <%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="_190526E_AS.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        .auto-style1 {
            width: 100%;
        }
        .auto-style2 {
            width: 86px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <table class="auto-style1">
            <tr>
                <td class="auto-style2">Login Page</td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td class="auto-style2">Login </td>
                <td>
                    <asp:TextBox ID="tb_Eaddress" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="auto-style2">Password </td>
                <td>
                    <asp:TextBox ID="tb_Password" runat="server" TextMode="Password"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="auto-style2">&nbsp;</td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td class="auto-style2">&nbsp;</td>
                <td>
                    <asp:Button ID="btn_login" runat="server" OnClick="btn_login_Click" Text="Login" />
                </td>
            </tr>
        </table>
        <div>
        </div>
    </form>
</body>
</html>
