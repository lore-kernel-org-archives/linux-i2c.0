From: Julia Lawall <Julia.Lawall-L2FTfq7BK8M@public.gmane.org>
Subject: [PATCH 0/11] introduce macros for i2c_msg initialization
Date: Sun,  7 Oct 2012 17:38:30 +0200
Message-ID: <1349624323-15584-1-git-send-email-Julia.Lawall@lip6.fr>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mauro Carvalho Chehab <mchehab-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rmallon-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, shubhrajyoti-l0cyMroinI0@public.gmane.org, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

This patch set introduces some macros for describing how an i2c_msg is
being initialized.  There are three macros: I2C_MSG_READ, for a read
message, I2C_MSG_WRITE, for a write message, and I2C_MSG_OP, for some other
kind of message, which is expected to be very rarely used.

Some i2c_msg initializations have been updated accordingly using the
following semantic patch:

// <smpl>
@r@
field list[n] ds;
type T;
identifier i;
@@

struct i2c_msg {
  ds
  T i;
  ...
};

@@
initializer list[r.n] is;
expression a;
identifier nm;
identifier r.i;
@@

struct i2c_msg nm = {
  is,
- a
+  .i = a
  ,...
};

@@
initializer list[r.n] is;
expression a;
identifier nm;
identifier r.i;
@@

struct i2c_msg nm[...] = { ..., {
  is,
- a
+  .i = a
  ,...}, ...};

@@
initializer list[r.n] is;
expression a;
identifier nm;
identifier r.i;
@@

struct i2c_msg nm[] = { ..., {
  is,
- a
+  .i = a
  ,...}, ...};

// --------------------------------------------------------------------
// ensure everyone has all fields, pointer case first

@rt@
type T;
identifier i;
@@

struct i2c_msg {
  ...
  T *i;
  ...
};

@t1@
expression e;
identifier nm,rt.i;
position p;
@@

struct i2c_msg nm = {@p
  .i = e,
};

@@
identifier nm,rt.i;
position p!= t1.p;
@@

struct i2c_msg nm = {@p
+ .i = NULL,
  ...
};

@t2@
expression e;
identifier nm,rt.i;
position p;
@@

struct i2c_msg nm[] = { ..., {@p
  .i = e,
}, ...};

@@
identifier nm,rt.i;
position p!= t2.p;
@@

struct i2c_msg nm[] = { ..., {@p
+ .i = NULL,
  ...
}, ...};

@t3@
expression e;
identifier nm,rt.i;
position p;
@@

struct i2c_msg nm[...] = { ..., {@p
  .i = e,
}, ...};

@@
identifier nm,rt.i;
position p!= t3.p;
@@

struct i2c_msg nm[...] = { ..., {@p
+ .i = NULL,
  ...
}, ...};

// ---------------------------------

@f1@
expression e;
identifier nm,r.i;
position p;
@@

struct i2c_msg nm = {@p
  .i = e,
};

@@
identifier nm,r.i;
position p!= f1.p;
@@

struct i2c_msg nm = {@p
+ .i = 0,
  ...
};

@f2@
expression e;
identifier nm,r.i;
position p;
@@

struct i2c_msg nm[] = { ..., {@p
  .i = e,
}, ...};

@@
identifier nm,r.i;
position p!= f2.p;
@@

struct i2c_msg nm[] = { ..., {@p
+ .i = 0,
  ...
}, ...};

@f3@
expression e;
identifier nm,r.i;
position p;
@@

struct i2c_msg nm[...] = { ..., {@p
  .i = e,
}, ...};

@@
identifier nm,r.i;
position p!= f3.p;
@@

struct i2c_msg nm[...] = { ..., {@p
+ .i = 0,
  ...
}, ...};

// --------------------------------------------------------------------

@@
constant c;
identifier x;
type T,T1;
T[] b;
@@

struct i2c_msg x =
  { .buf = \((T1)b\|(T1)(&b)\|(T1)(&b[0])\), .len =
(
0
|
  sizeof (...)
|
- c
+ sizeof(b)
)
  };

@@
constant c;
identifier x;
type T,T1;
T[] b;
@@

struct i2c_msg x[...] =  {...,
  { .buf = \((T1)b\|(T1)(&b)\|(T1)(&b[0])\), .len =
(
0
|
  sizeof (...)
|
- c
+ sizeof(b)
)
  } ,...};

@@
constant c;
identifier x;
type T,T1;
T[] b;
@@

struct i2c_msg x[] =  {...,
  { .buf = \((T1)b\|(T1)(&b)\|(T1)(&b[0])\), .len =
(
0
|
  sizeof (...)
|
- c
+ sizeof(b)
)
  } ,...};

@@
constant c;
identifier x;
type T1;
expression b;
@@

struct i2c_msg x =
  { .buf = (T1)(&b), .len =
(
0
|
  sizeof (...)
|
- c
+ sizeof(b)
)
  };

@@
constant c;
identifier x;
type T1;
expression b;
@@

struct i2c_msg x[...] =  {...,
  { .buf = (T1)(&b), .len =
(
0
|
  sizeof (...)
|
- c
+ sizeof(b)
)
  } ,...};

@@
constant c;
identifier x;
type T1;
expression b;
@@

struct i2c_msg x[] =  {...,
  { .buf = (T1)(&b), .len =
(
0
|
  sizeof (...)
|
- c
+ sizeof(b)
)
  } ,...};

// --------------------------------------------------------------------

@@
expression a,b,c;
identifier x;
@@

struct i2c_msg x =
- {.addr = a, .buf = b, .len = c, .flags = I2C_M_RD}
+ I2C_MSG_READ(a,b,c)
 ;

@@
expression a,b,c;
identifier x;
@@

struct i2c_msg x =
- {.addr = a, .buf = b, .len = c, .flags = 0}
+ I2C_MSG_WRITE(a,b,c)
 ;

// has to come before the next rule, which matcher fewer fields
@@
expression a,b,c,d;
identifier x;
@@

struct i2c_msg x = 
- {.addr = a, .buf = b, .len = c, .flags = d}
+ I2C_MSG_OP(a,b,c,d)
 ;

// --------------------------------------------------------------------

@@
expression a,b,c;
identifier x;
@@

struct i2c_msg x[] = {...,
- {.addr = a, .buf = b, .len = c, .flags = I2C_M_RD}
+ I2C_MSG_READ(a,b,c)
 ,...};

@@
expression a,b,c;
identifier x;
@@

struct i2c_msg x[] = {..., 
- {.addr = a, .buf = b, .len = c, .flags = 0}
+ I2C_MSG_WRITE(a,b,c)
 ,...};

@@
expression a,b,c,d;
identifier x;
@@

struct i2c_msg x[] =  {...,
- {.addr = a, .buf = b, .len = c, .flags = d}
+ I2C_MSG_OP(a,b,c,d)
 ,...};

// --------------------------------------------------------------------

@@
expression a,b,c;
identifier x;
@@

struct i2c_msg x[...] =  {...,
- {.addr = a, .buf = b, .len = c, .flags = I2C_M_RD}
+ I2C_MSG_READ(a,b,c)
 ,...};

@@
expression a,b,c;
identifier x;
@@

struct i2c_msg x[...] =  {...,
- {.addr = a, .buf = b, .len = c, .flags = 0}
+ I2C_MSG_WRITE(a,b,c)
 ,...};

@@
expression a,b,c,d;
identifier x;
@@

struct i2c_msg x[...] = {...,
- {.addr = a, .buf = b, .len = c, .flags = d}
+ I2C_MSG_OP(a,b,c,d)
 ,...};

// --------------------------------------------------------------------
// got everything?

@check1@
identifier nm;
position p;
@@

struct i2c_msg nm@p = {...};

@script:python@
p << check1.p;
@@

cocci.print_main("",p)

@check2@
identifier nm;
position p;
@@

struct i2c_msg nm@p [] = {...,{...},...};

@script:python@
p << check2.p;
@@

cocci.print_main("",p)

@check3@
identifier nm;
position p;
@@

struct i2c_msg nm@p [...] = {...,{...},...};

@script:python@
p << check3.p;
@@

cocci.print_main("",p)
// </smpl>
