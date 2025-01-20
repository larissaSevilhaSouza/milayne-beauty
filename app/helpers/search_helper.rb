module SearchHelper
  def type_name(type )
    case type
    when "PostCategory"
      "Categoria de noticia"
    when "BidComplete"
      "Resultado de Licitação"
    when "BidNotice"
      "Aviso de Licitação"
    when "BidResult"
      "Resultado da Licitação"
    when "ContractEnd"
      "Fim do Contrato"
    when "Contract"
      "Contrato"
    when "Law"
      "Lei"
    when "OfficialDiary"
      "Diário Oficial"
    when "Post "
      "Postagem"
    when "BiddingCategory"
      "Categoria de Licitação"
    else
      "Desconhecido"
    end
  end

  def path_for(result)
    case result[:type]
    when "BiddingCategory"       
      biddings_path
    when "BidComplete"
      bid_complete_path(result[:slug])
    when "BidNotice"
      bid_notice_path(result[:slug])
    when "BidResult"
      bid_result_path(result[:slug])
    when "ContractEnd"
      bid_contract_end_path
    when "Contract"
      bid_contract_path 
    when "Law"
      laws_path 
    when "OfficialDiary"
      official_diarys_path
    when "Post"
      post_path(result[:slug])
    when "PostCategory"
        posts_category_path(category: result[:slug])
    else
      "#"
    end
  end
end
