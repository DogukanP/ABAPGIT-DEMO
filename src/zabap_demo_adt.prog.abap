REPORT zabap_demo_adt.

TABLES  : mara.
TYPES: BEGIN OF type_mara,
         matnr TYPE matnr,
         mtart TYPE mtart,
         matkl TYPE matkl,
       END OF type_mara,
       type_t_mara TYPE STANDARD TABLE OF type_mara.

DATA: t_mara TYPE type_t_mara.

DATA : obj_alv     TYPE REF TO cl_salv_table,
       obj_alv_fct TYPE REF TO cl_salv_functions_list.

SELECT-OPTIONS : o_matnr FOR mara-matnr.

SELECT matnr mtart matkl INTO TABLE
        t_mara FROM
        mara WHERE
        matnr IN o_matnr.

TRY.
    CALL METHOD cl_salv_table=>factory
      EXPORTING
        list_display = if_salv_c_bool_sap=>false    " ALV Displayed in List Mode
*       r_container  =     " Abstract Container for GUI Controls
*       container_name =
      IMPORTING
        r_salv_table = obj_alv   " Basis Class Simple ALV Tables
      CHANGING
        t_table      = t_mara.
*      CATCH cx_salv_msg.    "
  CATCH cx_salv_msg.
    MESSAGE ID 'BC' TYPE 'E' NUMBER '202' WITH 'cx_salv_msg' sy-msgv1 sy-msgv2 'cl_salv_table=>factory'.
ENDTRY .

obj_alv->set_screen_popup(
    EXPORTING
    start_column = 10
    end_column = 60
    start_line = 02
    end_line = 22
).

obj_alv_fct = obj_alv->get_functions( ).
obj_alv_fct->set_all( ).
obj_alv->display( ).
