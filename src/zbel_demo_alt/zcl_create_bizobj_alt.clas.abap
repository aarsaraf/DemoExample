CLASS zcl_create_bizobj_alt DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_create_bizobj_alt IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

  DATA lv_key TYPE zobjid .

try.

lv_key = |{ cl_abap_context_info=>get_system_date( ) }{ cl_abap_context_info=>get_system_time( )  }{ cl_abap_context_info=>get_user_formatted_name( ) }|.
 CATCH  CX_ABAP_CONTEXT_INFO_ERROR INTO data(lo_exp_ref).

ENDTRY.



MODIFY ENTITIES OF zr_biz_object_hdr_Alt
           ENTITY BusinessObjectHeaderAlt
             CREATE
               FIELDS (
                          BusinessObjectID BusinessObjectNotes BusinessObjectStatus  )
               WITH VALUE #( ( %cid     = 'H001'
                               %data    = VALUE #(
                                                    BusinessObjectID      =  lv_key
                                                    BusinessObjectNotes   =  'Header Creation'
                                                    BusinessObjectStatus   = 'H1'
                                                    ) ) )

             CREATE BY \_Item
               FIELDS (

                            BusinessObjectItem BusinessObjectItemNotes BusinessObjectItemStatus
                           BusinessObjectItemQuantity BusinessObjectItemUom
                         )
               WITH VALUE #( ( %cid_ref = 'H001'

                               %target = VALUE #( ( %cid                          = 'I001'
                                                       BusinessObjectItem         = '00001'
                                                       BusinessObjectItemNotes    = 'Item Created'
                                                       BusinessObjectItemStatus   = 'I1'
                                                       BusinessObjectItemQuantity = '100.11'
                                                       BusinessObjectItemUom      = 'KGS'
                                                     ) ) ) )

                 MAPPED   DATA(ls_mapped)
                 FAILED   DATA(ls_failed) ##NEEDED
                 REPORTED DATA(ls_reported).

COMMIT ENTITIES.

  ENDMETHOD.
ENDCLASS.
