context("JSON Pretty Printing App", () => {
  beforeEach(() => {
    cy.visit("http://localhost:3000/")
  })

  it("does not format JSON automatically", () => {
    cy.get("textarea")
      .clear()
      .type("[1, 2,3,\n   4]")
    // makes sure nothing happens
    cy.wait(100)
    cy.get("textarea")
      .invoke("val")
      .should("eq", "[1, 2,3,\n   4]")
  })

  it("formats JSON when you press the button", () => {
    cy.get("textarea")
      .clear()
      .type("[1, 2,3,\n   4]")
    cy.get("button").click()
    cy.get("textarea")
      .invoke("val")
      .should("eq", "[1, 2, 3, 4]")
  })

  it("reports error if JSON is invalid, but clears if text changes", () => {
    cy.get("textarea")
      .clear()
      .type("[1, 2, 3,")
    cy.wait(100)
    cy.get('.error').should('not.exist')
    cy.get("button").click()
    cy.get('.error').should('exist')
    cy.get("textarea").type("4")
    cy.get('.error').should('not.exist')
  })
})
