import requests
import json

API_ENDPOINT = "http://np-server.local:3001/v1/chat/completions"

def ask_openai(prompt):
    headers = {
        "Content-Type": "application/json",
    }

    data = {
      "messages": [
        {
          "content": "You are a helpful AI penpal. Respond in long form as a letter.",
          "role": "system"
        },
        {
          "content": prompt,
          "role": "user"
        }
      ],
      "max_tokens": 4000
    }

    response = requests.post(API_ENDPOINT, headers=headers, data=json.dumps(data))

    if response.status_code == 200:
        return response.json()["choices"][0]["message"]
    else:
        raise Exception(f"Error {response.status_code}: {response.text}")

# Example usage
if __name__ == "__main__":
    question = input("Ask a question: ")
    answer = ask_openai(question)
    print(f"Answer: {answer}")

