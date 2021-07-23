(macro pkg [name ?config]
  (fn merge-tables [a b]
    (fn is-type [v type-name] (= (type v) type-name))
    (fn both-have-type [a b type-name] (and (is-type a type-name) (is-type b type-name)))
    (var merged {})

    (each [ k v (pairs a) ]
      (tset merged k v))

    (each [ k v (pairs b) ]
      (let [ other-value (. a k) ]
        (tset merged k (if (both-have-type v other-value :table) 
                            (merge-tables v other-value)
                            v))))
    merged)
    
    (assert name "expected a name to the package")
    (if ?config 
      (merge-tables { 1 name } ?config)
      name)
)

(print (pkg :sumeuoaehaoutsaoen))
(print (pkg :hello { :requires :devicons }))

