//
//  Supabase.swift
//  ExploreAble
//
//  Created by Aadi Shiv Malhotra on 1/21/25.
//

import Foundation
import Supabase

let supabase = SupabaseClient(
    supabaseURL: URL(string: "https://rfgxwslemuautusuecrs.supabase.co")!,
    supabaseKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InJmZ3h3c2xlbXVhdXR1c3VlY3JzIiwicm9sZSI6ImFub24iLCJpYXQiOjE3Mjk0Mzg0MjUsImV4cCI6MjA0NTAxNDQyNX0.hc3cIW6UCBIFf_54bldNEPBkak8IySOmbKMJXe8de1g"
)
