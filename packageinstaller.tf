terraform {
  required_providers {
    azapi = {
      source = "Azure/azapi"
    }
  }
}

provider "azapi" {
}

resource "null_resource" "install_packages" {
  depends_on = [azurerm_windows_virtual_machine.example]

  provisioner "remote-exec" {
    inline = [
      # "powershell.exe -Command 'Set-Location C:\\Users\\Default'",
      # "powershell.exe -Command 'New-Item mytextfile.txt'",
      # "powershell.exe -Command 'Add-Content mytextfile.txt -Value \"this is for testing install\"'"
      # # Add more PowerShell commands as needed
    ]

    connection {
      type     = "winrm"
      host     = azurerm_windows_virtual_machine.example.public_ip_address
      user     = azurerm_windows_virtual_machine.example.admin_username
      password = azurerm_windows_virtual_machine.example.admin_password
    }
  }

  provisioner "local-exec" {
    command = "echo 'Package installed successfully'"
  }
}
