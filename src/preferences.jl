module Prefs

using Preferences
using ..ThreadPinning: is_valid_pinning_symbol, is_valid_places_symbol

const ALL_PREFERENCES = ("pinning", "places")

"Query whether the pinning strategy preference is set"
function has_pinning()
    @has_preference("pinning")
end

"Get the pinning strategy. Returns `nothing` if not set."
function get_pinning()
    p = @load_preference("pinning")
    if isnothing(p)
        return nothing
    else
        s = Symbol(p)
        if !is_valid_pinning_symbol(s)
            error("`$s` is not a valid pinning strategy preference")
        else
            return s
        end
    end
end

"Set the pinning strategy preference"
function set_pinning(s::Symbol)
    if !is_valid_pinning_symbol(s)
        throw(ArgumentError("`$s` is not a valid pinning strategy"))
    end
    @set_preferences!("pinning"=>String(s))
    return nothing
end

"Query whether the places preference is set"
function has_places()
    @has_preference("places")
end

"Get the places preference. Returns `nothing` if not set."
function get_places()
    p = @load_preference("places")
    if isnothing(p)
        return nothing
    else
        s = Symbol(p)
        if !is_valid_places_symbol(s)
            error("`$s` is not a valid places preference")
        else
            return s
        end
    end
end

"Set the places preference"
function set_places(s::Symbol)
    if !is_valid_places_symbol(s)
        throw(ArgumentError("`$s` is not a valid places symbol"))
    end
    @set_preferences!("places"=>String(s))
    return nothing
end

"Clear all ThreadPinning.jl related preferences"
function clear()
    @delete_preferences!(ALL_PREFERENCES...)
end

"Show all ThreadPinning.jl related preferences"
function showall()
    for pref in ALL_PREFERENCES
        val = @load_preference(pref)
        println("$pref => $val")
    end
    return nothing
end

end # module