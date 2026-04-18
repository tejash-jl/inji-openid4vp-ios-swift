import Foundation

struct AuthorizationResponse {
    let vpToken: VPTokenType
    let presentationSubmission: PresentationSubmission
    let state: String?

    static let className = String(describing: AuthorizationResponse.self)

    func toJsonEncodedMap() throws -> [String: String] {
        var bodyParams: [String: String] = [:]

        bodyParams["vp_token"] = try encode(vpToken, fieldName: "vp_token", className: Self.className)
        bodyParams["presentation_submission"] = try encode(
            presentationSubmission,
            fieldName: "presentation_submission",
            className: Self.className
        )

        if let state = state {
            bodyParams["state"] = state
        }

        return bodyParams
    }
}


public struct AnyEncodable: Encodable {
    private let _encode: (Encoder) throws -> Void

    public init<T: Encodable>(_ value: T) {
        self._encode = value.encode
    }

    public func encode(to encoder: Encoder) throws {
        try _encode(encoder)
    }
}



public enum VPTokenType: Encodable {
    case vpTokenArray([VPToken])
    case vpTokenElement(VPToken)

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .vpTokenArray(let tokens):
            let wrapped = tokens.map { AnyEncodable($0) }
            try container.encode(wrapped)
        case .vpTokenElement(let token):
            try container.encode(AnyEncodable(token))
        }
    }
}
