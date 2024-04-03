from transformers import AutoTokenizer
import argparse
import os

def save_tokenizer(model_name: str, save_directory: str):
    """
    Save the tokenizer dir for a model to a local directory. This is needed
    for the triton ensemble.
    """
    os.makedirs(save_directory, exist_ok=True)
    tokenizer = AutoTokenizer.from_pretrained(model_name)
    tokenizer.save_pretrained(save_directory)
    print(f"Tokenizer saved to {save_directory}")

def main():
    # Create the parser
    parser = argparse.ArgumentParser(description="Save a tokenizer to a local directory.")

    # Add the arguments
    parser.add_argument('model_name', type=str, help='The model name of the tokenizer to save.')
    parser.add_argument('save_directory', type=str, help='The local directory where the tokenizer should be saved.')

    # Execute the parse_args() method
    args = parser.parse_args()

    save_tokenizer(args.model_name, args.save_directory)

if __name__ == "__main__":
    main()

