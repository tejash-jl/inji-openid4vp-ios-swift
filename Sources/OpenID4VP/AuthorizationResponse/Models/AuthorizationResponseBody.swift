struct AuthorizationResponseBody: Encodable {
    let vp_token: VpToken
    let presentation_submission: PresentationSubmission
    let state: String
}
