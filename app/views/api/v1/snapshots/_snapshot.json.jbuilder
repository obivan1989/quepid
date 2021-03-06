# frozen_string_literal: true

json.id     snapshot.id
json.name   snapshot.name
json.time   snapshot.created_at

if with_docs
  json.docs do
    snapshot.snapshot_queries.each do |query|
      docs = query.snapshot_docs.map do |doc|
        { id: doc.doc_id, explain: doc.explain }
      end

      json.set! query.query_id, docs
    end
  end
end

if with_docs
  json.queries do
    json.array! snapshot.snapshot_queries.collect(&:query), partial: 'api/v1/queries/query', as: :query
  end
end
