import os
from dotenv import load_dotenv
import openai

# Load environment variables from .env file
load_dotenv()

# Get the API key from the environment variable
api_key = os.getenv('OPENAI_API_KEY')

if not api_key:
    raise ValueError("API key is not set. Make sure the .env file is correctly configured and loaded.")

# Set the API key for the OpenAI client
openai.api_key = api_key

def get_ai_response(mock=False):
    try:
        if mock:
            # Mock response to simulate the OpenAI API call
            ai_message = (
                "I'm here to help you with all things DevOps.\n\n"
                "For more information regarding this project, visit my GitHub repository:\n"
                "https://github.com/cloudquiza/hello_devops_world"
            )
        else:
            response = openai.ChatCompletion.create(
                model="gpt-3.5-turbo",
                messages=[
                    {"role": "system", "content": "You are a helpful assistant."},
                    {"role": "user", "content": "Hello DevOps World"}
                ]
            )
            ai_message = response.choices[0].message['content']

            # Friendly message with a GitHub link
            ai_message += (
                "\n\nFor more information regarding this project, visit my GitHub repository:\n"
                "https://github.com/cloudquiza/hello_devops_world"
            )

        return ai_message
        
    except openai.error.RateLimitError:
        print("Rate limit exceeded. Please try again later or check your quota.")
        return None

print("Hello DevOps World")

# Set mock=True for a mock response, mock=False for a real API call to OpenAI.
ai_message = get_ai_response(mock=False)
if ai_message:
    print(ai_message)
