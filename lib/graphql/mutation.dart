String login = """
  mutation login(\$email: String!, \$password: String!) {
    login(email: \$email, password: \$password) {
      token
    }
  }
""";

String createDraft = """
  mutation createDraft(\$title: String!, \$content: String!){
    createDraft(title: \$title, \$content: \$content) {
      published
      author {
        name
      }
    }
  }
""";