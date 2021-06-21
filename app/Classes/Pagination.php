<?php

namespace App\Classes;


class Pagination{

   private $content = array();
   private $totalPages = 0;
   private $totalElements = 0;
   private $size = 0;
   private $currentPage = 0;
   private $from = 0;
   private $to = 0;

    function __constructor() {              
      $this->content = [];
      $this->totalPages = 0;
      $this->totalElements = 0;
      $this->size = 0;
      $this->currentPage = 0;
      $this->from = 0;
      $this->to = 0;
    } 


  public function setContent($content){
    $this->content = $content;
  }

  public function setTotalElements($totalElements){
    $this->totalElements = $totalElements;
  }

  public function getSize(){
    return $this->size;
  }

  public function setSize($size){
    $this->size = $size;
  }

  public function getCurrentPage(){
   return  $this->currentPage;;
  }

  public function setCurrentPage($currentPage){
    $this->currentPage = $currentPage;
  }

  public function getFrom(){
    return $this->from ;
  }

  public function setFrom($from){
    $this->from = $from;
  }

  public function getTo(){
    return $this->to;
  }

  public function setTo($to){
    $this->to = $to;
  }

  public function calculOffset(){
    $this->from = $this->size * $this->currentPage;
    $this->to = ($this->size * $this->currentPage) + $this->size;
  }

  public function calculTotalPages(){
       $this->totalPages = ceil($this->totalElements  / $this->size);
  }

   public function generatePagination($content,$totalElements){
   
       $this->content =$content;
       $this->totalElements = $totalElements;
       $this->calculTotalPages();
       return (object) [
                        'content' => $this->content,
                        'totalPages' => $this->totalPages,
                        'totalElements' => $this->totalElements,
                        'size' => $this->size,
                        'currentPage' => $this->currentPage,
                        'from' => $this->from,
                        'to' => $this->to
                    ];
   }

}