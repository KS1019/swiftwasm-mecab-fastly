import Compute

struct Response: Codable {
    let text: String
    let response_type: String
}

import IPADic
import Mecab_Swift

@main
struct ComputeApp {
    static func main() async throws {
        try await onIncomingRequest { req, res in
            switch (req.method, req.url.path) {
            case (.post, "/command/ping-pong"):
                let content = Response(text: "pong", response_type: "in_channel")
                try await res.status(200).send(content)
            case (.get, "/mecab"):
                let ipadic = IPADic()
                let ipadicTokenizer = try Tokenizer(dictionary: ipadic)
                let str = try await req.body.text()
                let ipadicTokens=ipadicTokenizer.tokenize(text: str, transliteration: .hiragana)
                let nouns = ipadicTokens.filter { $0.partOfSpeech == .noun }.map { $0.base }.joined(separator: "+")
                try await res.status(200).send(nouns)
            default:
                try await res.status(404).send()
            }
        }
    }
}