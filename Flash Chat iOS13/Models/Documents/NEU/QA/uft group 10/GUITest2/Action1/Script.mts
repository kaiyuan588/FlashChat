rowCount = DataTable.GetSheet(1).GetRowCount

For Iterator = 1 To rowCount Step 1
DataTable.SetCurrentRow(Iterator)
Browser("Welcome: Mercury Tours").Page("Welcome: Mercury Tours").Link("REGISTER").Click @@ script infofile_;_ZIP::ssf47.xml_;_
Browser("Welcome: Mercury Tours").Page("Register: Mercury Tours").WebEdit("firstName").Set DataTable.value(1)
Browser("Welcome: Mercury Tours").Page("Register: Mercury Tours").WebEdit("lastName").Set DataTable.value(2)
Browser("Welcome: Mercury Tours").Page("Register: Mercury Tours").WebEdit("firstName").Check CheckPoint("firstName") @@ script infofile_;_ZIP::ssf51.xml_;_
Browser("Welcome: Mercury Tours").Page("Register: Mercury Tours").WebEdit("lastName").Check CheckPoint("lastName")
Browser("Welcome: Mercury Tours").Page("Register: Mercury Tours").WebEdit("phone").Set DataTable.value(3) @@ script infofile_;_ZIP::ssf4.xml_;_
Browser("Welcome: Mercury Tours").Page("Register: Mercury Tours").WebEdit("userName").Set DataTable.value(4) @@ script infofile_;_ZIP::ssf5.xml_;_
Browser("Welcome: Mercury Tours").Page("Register: Mercury Tours").WebEdit("address1").Set DataTable.value(5) @@ script infofile_;_ZIP::ssf6.xml_;_
Browser("Welcome: Mercury Tours").Page("Register: Mercury Tours").WebEdit("address2").Set DataTable.value(6) @@ script infofile_;_ZIP::ssf7.xml_;_
Browser("Welcome: Mercury Tours").Page("Register: Mercury Tours").WebEdit("city").Set DataTable.value(7)
Browser("Welcome: Mercury Tours").Page("Register: Mercury Tours").WebEdit("state").Set DataTable.value(8) @@ script infofile_;_ZIP::ssf9.xml_;_
Browser("Welcome: Mercury Tours").Page("Register: Mercury Tours").WebEdit("postalCode").Set DataTable.value(9) @@ script infofile_;_ZIP::ssf10.xml_;_
Browser("Welcome: Mercury Tours").Page("Register: Mercury Tours").WebEdit("email").Set DataTable.value(10) @@ script infofile_;_ZIP::ssf12.xml_;_
Browser("Welcome: Mercury Tours").Page("Register: Mercury Tours").WebEdit("password").SetSecure DataTable.value(11) @@ script infofile_;_ZIP::ssf13.xml_;_
Browser("Welcome: Mercury Tours").Page("Register: Mercury Tours").WebEdit("confirmPassword").SetSecure DataTable.value(12) @@ script infofile_;_ZIP::ssf14.xml_;_
Browser("Welcome: Mercury Tours").Page("Register: Mercury Tours").Image("register").Click 52,12
Next

