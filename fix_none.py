import os
import re

def fix_templates():
    templates_dir = "templates"
    
    # Regex para capturar: <img src="{{ variable }}" ...>
    # Y reemplazarlo con: <img src="{{ variable if variable and variable != 'None' else '' }}" ...>
    pattern = re.compile(r'<img\s+src="\{\{\s*([^"\}]+)\s*\}\}"')
    
    for filename in os.listdir(templates_dir):
        if not filename.endswith(".html"):
            continue
            
        filepath = os.path.join(templates_dir, filename)
        with open(filepath, "r", encoding="utf-8") as f:
            content = f.read()
            
        # Reemplazo: {{ var if var and var != 'None' else '' }}
        # Excluimos url_for que ya son llamadas a funciones válidas
        def replacer(match):
            var_content = match.group(1).strip()
            if "url_for" in var_content or " if " in var_content:
                return match.group(0) # No modificar
            
            return f'<img src="{{{{ {var_content} if {var_content} and {var_content} != \'None\' else \'\' }}}}"'
            
        new_content = pattern.sub(replacer, content)
        
        if new_content != content:
            with open(filepath, "w", encoding="utf-8") as f:
                f.write(new_content)
            print(f"Corregido {filename}")

if __name__ == "__main__":
    fix_templates()
