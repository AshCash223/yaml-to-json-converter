import yaml
import json

def convert_yaml_to_json(yaml_file, json_file):
    with open(yaml_file, 'r', encoding='utf-8') as stream:
        yaml_data = yaml.safe_load(stream)
        with open(json_file, 'w', encoding='utf-8') as json_stream:
            json.dump(yaml_data, json_stream, indent=4, ensure_ascii=False)

if __name__ == "__main__":
    convert_yaml_to_json('assets/lang.yaml', 'assets/lang.json')