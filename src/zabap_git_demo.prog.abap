REPORT ZABAP_GIT_DEMO.

data : ls_out like zabap_demo_s_1,
       lt_out like TABLE OF zabap_demo_s_1.

select * from zabap_demo_t_1 into TABLE lt_out.


LOOP AT lt_out into ls_out.
  write :/ ls_out-name,ls_out-blgn.
ENDLOOP.
