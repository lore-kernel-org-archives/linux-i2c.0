From: Michael Mercier <michael.mercier-MZpvjPyXg2s@public.gmane.org>
Subject: Re: i2c-tools: add compatibility for python2/3 to py-smbus
Date: Thu, 22 Jan 2015 09:56:58 +0100
Message-ID: <1421917018.21840.0@smtp.inria.fr>
References: <CA+TH9VkT1K2aqAuNOLsGiU407OA4NYcMVaUakEQgSWLpMBBg2A@mail.gmail.com>
	<20150119230327.0224d0ba@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150119230327.0224d0ba-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Cc: Angelo Compagnucci <angelo.compagnucci-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Renz, Bernhard" <bernhard.renz-//tT4aWmXyZBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Jean,

I just tried you patch and I got an error when I try to import the=20
smbus python package:

import smbus

ImportError:=20
/usr/local/lib/python3.2/dist-packages/smbus.cpython-32mu.so: undefined=
=20
symbol: i2c_smbus_process_call

Any idea?

Thanks,

Michael Mercier

Le lun. 19 janv. 2015 =C3=A0 23:03, Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org> a=20
=C3=A9crit :
> Hi Angelo,
>=20
> On Mon, 19 Jan 2015 16:13:26 +0100, Angelo Compagnucci wrote:
>>  Dear Jean Delvare,
>>=20
>>  Attached you can find a patch that implements py-smbus for python3
>>  with python2 backward compatibility.
>>  This patch is not heavily tested, but it wors well for me.
>=20
> Thanks a lot for your work. I was finally about to look into this and
> you saved me some time :-)
>=20
>>  Unfortunately, I don't know how to use svn for sharing source code,=
=20
>> it
>>  is so ugly compared to git and it doesn't provide a way to send
>>  patches via email, so the best way I found was to attach the patch
>>  file.
>=20
> This is fine. You know, this is how people did before git was=20
> invented,
> and it worked well ;-)
>=20
>>  Hope this helps!
>=20
> Oh yeah. I started from your version and improved it as follows:
> * Added back missing header files as pointed out by Michael. I have a
>   hard time believing you did not need these.
> * Reverted some undesirable white space changes.
> * Turned most #ifndefs into #ifdefs for readability.
> * Shared the module documentation string.
> * Added some preprocessing magic to limit the number of #ifdefs.
> * Dropped PY3 definition.
>=20
> Result is below, my patch is significantly smaller and the resulting
> code is IMHO more readable. It builds fine for both python 2.7 and=20
> 3.3,
> however I can't test it, so I would appreciate if you guys could test
> and report. If it works fine I'll commit it tomorrow.
>=20
> For convenience I have also put the pre-patched file at:
> http://jdelvare.nerim.net/devel/i2c-tools/smbusmodule.c
>=20
> Thanks.
> ---
>  py-smbus/smbusmodule.c |   47=20
> +++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 45 insertions(+), 2 deletions(-)
>=20
> --- i2c-tools.orig/py-smbus/smbusmodule.c	2015-01-19=20
> 22:09:39.624016377 +0100
> +++ i2c-tools/py-smbus/smbusmodule.c	2015-01-19 22:59:03.651572099=20
> +0100
> @@ -94,7 +94,11 @@ SMBus_dealloc(SMBus *self)
>  	PyObject *ref =3D SMBus_close(self);
>  	Py_XDECREF(ref);
>=20
> +#if PY_MAJOR_VERSION >=3D 3
> +	Py_TYPE(self)->tp_free((PyObject *)self);
> +#else
>  	self->ob_type->tp_free((PyObject *)self);
> +#endif
>  }
>=20
>  #define MAXPATH 16
> @@ -434,11 +438,19 @@ SMBus_list_to_data(PyObject *list, union
>=20
>  	for (ii =3D 0; ii < len; ii++) {
>  		PyObject *val =3D PyList_GET_ITEM(list, ii);
> +#if PY_MAJOR_VERSION >=3D 3
> +		if (!PyLong_Check(val)) {
> +			PyErr_SetString(PyExc_TypeError, msg);
> +			return 0; /* fail */
> +		}
> +		data->block[ii+1] =3D (__u8)PyLong_AS_LONG(val);
> +#else
>  		if (!PyInt_Check(val)) {
>  			PyErr_SetString(PyExc_TypeError, msg);
>  			return 0; /* fail */
>  		}
>  		data->block[ii+1] =3D (__u8)PyInt_AS_LONG(val);
> +#endif
>  	}
>=20
>  	return 1; /* success */
> @@ -637,9 +649,14 @@ static PyGetSetDef SMBus_getset[] =3D {
>  };
>=20
>  static PyTypeObject SMBus_type =3D {
> +#if PY_MAJOR_VERSION >=3D 3
> +	PyVarObject_HEAD_INIT(NULL, 0)
> +	"SMBus",			/* tp_name */
> +#else
>  	PyObject_HEAD_INIT(NULL)
>  	0,				/* ob_size */
>  	"smbus.SMBus",			/* tp_name */
> +#endif
>  	sizeof(SMBus),			/* tp_basicsize */
>  	0,				/* tp_itemsize */
>  	(destructor)SMBus_dealloc,	/* tp_dealloc */
> @@ -678,24 +695,50 @@ static PyTypeObject SMBus_type =3D {
>  	SMBus_new,			/* tp_new */
>  };
>=20
> +#if PY_MAJOR_VERSION >=3D 3
> +static struct PyModuleDef SMBusModule =3D {
> +	PyModuleDef_HEAD_INIT,
> +	"SMBus",			/* m_name */
> +	SMBus_module_doc,  		/* m_doc */
> +	-1,				/* m_size */
> +	NULL,				/* m_methods */
> +	NULL,				/* m_reload */
> +	NULL,				/* m_traverse */
> +	NULL,				/* m_clear */
> +	NULL,				/* m_free */
> +};
> +#define INIT_RETURN(m)	return m
> +#define INIT_FNAME	PyInit_smbus
> +#else
>  static PyMethodDef SMBus_module_methods[] =3D {
>  	{NULL}
>  };
> +#define INIT_RETURN(m)	return
> +#define INIT_FNAME	initsmbus
> +#endif
>=20
>  #ifndef PyMODINIT_FUNC	/* declarations for DLL import/export */
>  #define PyMODINIT_FUNC void
>  #endif
>  PyMODINIT_FUNC
> -initsmbus(void)
> +INIT_FNAME(void)
>  {
>  	PyObject* m;
>=20
>  	if (PyType_Ready(&SMBus_type) < 0)
> -		return;
> +		INIT_RETURN(NULL);
>=20
> +#if PY_MAJOR_VERSION >=3D 3
> +	m =3D PyModule_Create(&SMBusModule);
> +#else
>  	m =3D Py_InitModule3("smbus", SMBus_module_methods, SMBus_module_do=
c);
> +#endif
> +	if (m =3D=3D NULL)
> +		INIT_RETURN(NULL);
>=20
>  	Py_INCREF(&SMBus_type);
>  	PyModule_AddObject(m, "SMBus", (PyObject *)&SMBus_type);
> +
> +	INIT_RETURN(m);
>  }
>=20
>=20
> --
> Jean Delvare
> SUSE L3 Support
