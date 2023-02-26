luaunit = require('luaunit')
assertEquals = luaunit.assertEquals
tt = require('textools')

TestTexFunctions = {} 
    function TestTexFunctions:test_trim()
        assertEquals(tt.trim("  bla  "), "bla")
        assertEquals(tt.trim("{bla}"), "{bla}")
        assertEquals(tt.trim("{bla}", "[{}]"), "bla")
    end

    function TestTexFunctions:test_find_end_brace()
        local function x(text, position)
            local y = tt.find_end_brace(text, position)
            if y ~= nil then 
                return text:sub(position, y)
            end
        end
        assertEquals(x("{flat white}", 2), "flat white}")
        assertEquals(x("my \\emph{flat \\textbf{white} latte}", 10), "flat \\textbf{white} latte}")
        -- no result if closing brace is not found
        assertEquals(x("{flat white}", 1), nil)
        assertEquals(x("no braces", 1), nil)
    end
    
    function TestTexFunctions:test_strip_tex_commands()
        assertEquals(tt.strip_tex_commands('this \\emph{is} important'), 'this is important')
        assertEquals(tt.strip_tex_commands('this \\emph{is \\textbf{very}} important'), 'this is very important')
        
    end

    function TestTexFunctions:test_get_tex_value()
        assertEquals(tt.get_tex_value("this \\emph{is} important", "emph"), "is")
        assertEquals(tt.get_tex_value("this \\emph{is \\textbf{very}} important", "emph"), "is \\textbf{very}")
        assertEquals(tt.get_tex_value("this \\emph{\\textbf{is very}} important", "emph"), "\\textbf{is very}")
    end

    function TestTexFunctions:test_split_comma()
        assertEquals(tt.split_comma("a, b"), {"a", "b"})
        assertEquals(tt.split_comma("a, {b, c}, d"), {"a", "{b, c}", "d"})
        assertEquals(tt.split_comma("a, {b, c}, not \\emph{this, or that} one"), {"a", "{b, c}", "not \\emph{this, or that} one"})
    end
luaunit.run()