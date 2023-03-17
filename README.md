# ScriptCreationTool


## What it does

This tool was created for the purpose of quickly creating local powershell, visual basic, and autoit scripts using the source code from example scripts/user defined functions/modules found online.  You simply input the name you want to name the script file in the input box (with or without extension).  If you do not provide an extension, then the type of script file must be indicated by selecting one of the radio buttons.  Then paste the source code into the edit control and click "Create".  If you already have a file in the script directory (configured upon first launch) with the same name as the text designated in the tool, then the tool will determine if the content in the already existing file is the same as the content input into the tool.  If the tool determines the text content is the same, it will overwrite the already existing script with the content from the tool.  If it determines the contents are not the same, it will open the udf/script file in the default text editor associated to that particular file's extension, and prompts you with the options to either overwrite the contents, rename the new file so there is no conflict, or cancel the operation.

![Picture](https://i.imgur.com/Zp43vp6.png)