struct AuthorizationResponseBody: Encodable {
    let vp_token: String
    let presentation_submission: PresentationSubmission
    let state: String
}
