describe("hcommand", function ()
    it("can be required", function ()
        require("hcommand")
    end)

    it("it can open a window", function ()
        require("hcommand").open()

        assert.are.is_true(require("hcommand").config.win_info.bufnr ~= nil)
        assert.are.is_true(require("hcommand").config.win_info.win_id ~= nil)
    end)

    it("it can close a window", function ()
        require("hcommand").close()

        assert.are.is_true(require("hcommand").config.win_info.bufnr == nil)
        assert.are.is_true(require("hcommand").config.win_info.win_id == nil)
    end)
end)

