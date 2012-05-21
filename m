From: "Renz, Bernhard" <bernhard.renz-//tT4aWmXyZBDgjK7y7TUQ@public.gmane.org>
Subject: RE: Howto compile py-smbus with python 3.2
Date: Mon, 21 May 2012 15:40:07 +0000
Message-ID: <DDF9A29ED50FA94F83C55CFA4BB8EF5F08A9E2@011-DB3MPN1-024.MGDPHG.emi.philips.com>
References: <DDF9A29ED50FA94F83C55CFA4BB8EF5F08323B@011-DB3MPN1-023.MGDPHG.emi.philips.com>
	<DDF9A29ED50FA94F83C55CFA4BB8EF5F08A9BD@011-DB3MPN1-024.MGDPHG.emi.philips.com>
 <20120521171419.2ef13147@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120521171419.2ef13147-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Content-Language: en-US
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Jean,

At the moment, I comment the Python2 code lines and add the Python3 ones. Below is the diff -ruNp output.
To get the code work for both platforms in one file, we have to make an if statement like if platform.python_version() >= 3.


--- smbusmodule.c       2012-05-14 17:47:22.606768184 +0200
+++ smbusmodule_org.c   2009-01-22 10:55:33.000000000 +0100
@@ -5,12 +5,12 @@
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
  * the Free Software Foundation; version 2 of the License.
- *
+ *
  * This program is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
- *
+ *
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
@@ -32,7 +32,7 @@
 #define I2C_SMBUS_I2C_BLOCK_DATA       8
 #endif

-/*yDoc_STRVAR(SMBus_module_doc,
+PyDoc_STRVAR(SMBus_module_doc,
        "This module defines an object type that allows SMBus transactions\n"
        "on hosts running the Linux kernel.  The host kernel must have I2C\n"
        "support, I2C device interface support, and a bus adapter driver.\n"
@@ -41,7 +41,6 @@
        "\n"
        "Because the I2C device interface is opened R/W, users of this\n"
        "module usually must have root permissions.\n");
-*/

 typedef struct {
        PyObject_HEAD
@@ -92,9 +91,7 @@ SMBus_dealloc(SMBus *self)
        PyObject *ref = SMBus_close(self);
        Py_XDECREF(ref);

-    /*old python 2.7 declaration */
-       /*self->ob_type->tp_free((PyObject *)self);*/
-       Py_TYPE(self)->tp_free((PyObject*)self);
+       self->ob_type->tp_free((PyObject *)self);
 }

 #define MAXPATH 16
@@ -434,11 +431,11 @@ SMBus_list_to_data(PyObject *list, union

        for (ii = 0; ii < len; ii++) {
                PyObject *val = PyList_GET_ITEM(list, ii);
-               if (!PyLong_Check(val)) {
+               if (!PyInt_Check(val)) {
                        PyErr_SetString(PyExc_TypeError, msg);
                        return 0; /* fail */
                }
-               data->block[ii+1] = (__u8)PyLong_AS_LONG(val);
+               data->block[ii+1] = (__u8)PyInt_AS_LONG(val);
        }

        return 1; /* success */
@@ -614,7 +611,7 @@ SMBus_set_pec(SMBus *self, PyObject *val
                return -1;
        }
        else if (pec == -1) {
-               PyErr_SetString(PyExc_TypeError,
+               PyErr_SetString(PyExc_TypeError,
                        "The pec attribute must be a boolean.");
                return -1;
        }
@@ -636,16 +633,12 @@ static PyGetSetDef SMBus_getset[] = {
        {NULL},
 };

-/* old Python 2.7 declaration */
 static PyTypeObject SMBus_type = {
-/*tatic struct PyModuleDef SMBus_type = {*/
-    /* old Python 2.7 declaration */
-       /* PyObject_HEAD_INIT(NULL) */
-       /*0,                             ob_size */
-       PyVarObject_HEAD_INIT(NULL, 0)
+       PyObject_HEAD_INIT(NULL)
+       0,                              /* ob_size */
        "SMBus",                        /* tp_name */
-       sizeof(SMBus),          /* tp_basicsize */
-       0,                                  /* tp_itemsize */
+       sizeof(SMBus),                  /* tp_basicsize */
+       0,                              /* tp_itemsize */
        (destructor)SMBus_dealloc,      /* tp_dealloc */
        0,                              /* tp_print */
        0,                              /* tp_getattr */
@@ -661,71 +654,45 @@ static PyTypeObject SMBus_type = {
        0,                              /* tp_getattro */
        0,                              /* tp_setattro */
        0,                              /* tp_as_buffer */
-       Py_TPFLAGS_DEFAULT, /* tp_flags */
-       SMBus_type_doc,         /* tp_doc */
+       Py_TPFLAGS_DEFAULT,             /* tp_flags */
+       SMBus_type_doc,                 /* tp_doc */
        0,                              /* tp_traverse */
        0,                              /* tp_clear */
        0,                              /* tp_richcompare */
        0,                              /* tp_weaklistoffset */
        0,                              /* tp_iter */
        0,                              /* tp_iternext */
-       SMBus_methods,  /* tp_methods */
-       0,              /* tp_members */
-       SMBus_getset,   /* tp_getset */
+       SMBus_methods,                  /* tp_methods */
+       0,                              /* tp_members */
+       SMBus_getset,                   /* tp_getset */
        0,                              /* tp_base */
        0,                              /* tp_dict */
        0,                              /* tp_descr_get */
        0,                              /* tp_descr_set */
        0,                              /* tp_dictoffset */
-       (initproc)SMBus_init,   /* tp_init */
+       (initproc)SMBus_init,           /* tp_init */
        0,                              /* tp_alloc */
-       SMBus_new,              /* tp_new */
+       SMBus_new,                      /* tp_new */
 };

-/*static PyMethodDef SMBus_module_methods[] = {
+static PyMethodDef SMBus_module_methods[] = {
        {NULL}
-};*/
-
-static struct PyModuleDef SMBusModule = {
-        PyModuleDef_HEAD_INIT,
-        "SMBus",     /* m_name */
-        "This module defines an object type that allows SMBus transactions\n"
-           "on hosts running the Linux kernel.  The host kernel must have I2C\n"
-           "support, I2C device interface support, and a bus adapter driver.\n"
-           "All of these can be either built-in to the kernel, or loaded from\n"
-           "modules.\n"
-           "\n"
-           "Because the I2C device interface is opened R/W, users of this\n"
-           "module usually must have root permissions.\n",  /* m_doc */
-        -1,                  /* m_size */
-        NULL,    /* m_methods */
-        NULL,                /* m_reload */
-        NULL,                /* m_traverse */
-        NULL,                /* m_clear */
-        NULL,                /* m_free */
-    };
+};

 #ifndef PyMODINIT_FUNC /* declarations for DLL import/export */
 #define PyMODINIT_FUNC void
 #endif
 PyMODINIT_FUNC
-PyInit_smbus(void)
+initsmbus(void)
 {
        PyObject* m;

-    if (PyType_Ready(&SMBus_type) < 0)
-               return NULL;
+       if (PyType_Ready(&SMBus_type) < 0)
+               return;

-    /* old Python 2.7 declaration */
-       /*m = Py_InitModule3("smbus", SMBus_module_methods, SMBus_module_doc);*/
-       m = PyModule_Create(&SMBusModule);
-
-    if (m == NULL)
-        return NULL;
+       m = Py_InitModule3("smbus", SMBus_module_methods, SMBus_module_doc);

        Py_INCREF(&SMBus_type);
        PyModule_AddObject(m, "SMBus", (PyObject *)&SMBus_type);
-
-       return m;
 }

-----Original Message-----
From: Jean Delvare [mailto:khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org]
Sent: Monday, 21 May, 2012 17:14
To: Renz, Bernhard
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Subject: Re: Howto compile py-smbus with python 3.2

Hi Bernhard,

On Mon, 21 May 2012 15:10:38 +0000, Renz, Bernhard wrote:
> Hello,
>
> I got it to work!
> With the following pages I did a conversion of py-smbus from Python2 to Python3:
> http://docs.python.org/release/3.1.5/extending/building.html#building
> http://python3porting.com/cextensions.html
>
> Here is the smbusmodule.c, which is based on the i2c-tools-3.1.0 release, which compile with Python3:
> Hope maybe Khali can provide it for other developers on his repository....

I'll do if you provide your changes as a patch (use diff -ruNp). BTW I hope that your changes do not break support for python version 2, a lot of distributions are still shipping that so we can't break it.

Thanks,
--
Jean Delvare

________________________________
The information contained in this message may be confidential and legally protected under applicable law. The message is intended solely for the addressee(s). If you are not the intended recipient, you are hereby notified that any use, forwarding, dissemination, or reproduction of this message is strictly prohibited and may be unlawful. If you are not the intended recipient, please contact the sender by return e-mail and destroy all copies of the original message.
