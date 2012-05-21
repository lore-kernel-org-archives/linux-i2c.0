From: "Renz, Bernhard" <bernhard.renz-//tT4aWmXyZBDgjK7y7TUQ@public.gmane.org>
Subject: RE: Howto compile py-smbus with python 3.2
Date: Mon, 21 May 2012 15:10:38 +0000
Message-ID: <DDF9A29ED50FA94F83C55CFA4BB8EF5F08A9BD@011-DB3MPN1-024.MGDPHG.emi.philips.com>
References: <DDF9A29ED50FA94F83C55CFA4BB8EF5F08323B@011-DB3MPN1-023.MGDPHG.emi.philips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <DDF9A29ED50FA94F83C55CFA4BB8EF5F08323B-8+ddyajbMjLtkydW1Tv2DlZafE0Mqj5e5/FHAH3NXZDDzftRWevZcw@public.gmane.org>
Content-Language: en-US
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hello,

I got it to work!
With the following pages I did a conversion of py-smbus from Python2 to Python3:
http://docs.python.org/release/3.1.5/extending/building.html#building
http://python3porting.com/cextensions.html

Here is the smbusmodule.c, which is based on the i2c-tools-3.1.0 release, which compile with Python3:
Hope maybe Khali can provide it for other developers on his repository....


/*
 * smbusmodule.c - Python bindings for Linux SMBus access through i2c-dev
 * Copyright (C) 2005-2007 Mark M. Hoffman <mhoffman-xQSgfq/1h4JiLUuM0BA3LQ@public.gmane.org>
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; version 2 of the License.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
 */

#include <Python.h>
#include "structmember.h"
#include <stdlib.h>
#include <stdio.h>
#include <fcntl.h>
#include <linux/i2c-dev.h>

/*
** These are required to build this module against Linux older than 2.6.23.
*/
#ifndef I2C_SMBUS_I2C_BLOCK_BROKEN
#undef I2C_SMBUS_I2C_BLOCK_DATA
#define I2C_SMBUS_I2C_BLOCK_BROKEN	6
#define I2C_SMBUS_I2C_BLOCK_DATA	8
#endif

/*yDoc_STRVAR(SMBus_module_doc,
	"This module defines an object type that allows SMBus transactions\n"
	"on hosts running the Linux kernel.  The host kernel must have I2C\n"
	"support, I2C device interface support, and a bus adapter driver.\n"
	"All of these can be either built-in to the kernel, or loaded from\n"
	"modules.\n"
	"\n"
	"Because the I2C device interface is opened R/W, users of this\n"
	"module usually must have root permissions.\n");
*/

typedef struct {
	PyObject_HEAD

	int fd;		/* open file descriptor: /dev/i2c-?, or -1 */
	int addr;	/* current client SMBus address */
	int pec;	/* !0 => Packet Error Codes enabled */
} SMBus;

static PyObject *
SMBus_new(PyTypeObject *type, PyObject *args, PyObject *kwds)
{
	SMBus *self;

	if ((self = (SMBus *)type->tp_alloc(type, 0)) == NULL)
		return NULL;

	self->fd = -1;
	self->addr = -1;
	self->pec = 0;

	return (PyObject *)self;
}

PyDoc_STRVAR(SMBus_close_doc,
	"close()\n\n"
	"Disconnects the object from the bus.\n");

static PyObject *
SMBus_close(SMBus *self)
{
	if ((self->fd != -1) && (close(self->fd) == -1)) {
		PyErr_SetFromErrno(PyExc_IOError);
		return NULL;
	}

	self->fd = -1;
	self->addr = -1;
	self->pec = 0;

	Py_INCREF(Py_None);
	return Py_None;
}

static void
SMBus_dealloc(SMBus *self)
{
	PyObject *ref = SMBus_close(self);
	Py_XDECREF(ref);

    /*old python 2.7 declaration */
	/*self->ob_type->tp_free((PyObject *)self);*/
	Py_TYPE(self)->tp_free((PyObject*)self);
}

#define MAXPATH 16

PyDoc_STRVAR(SMBus_open_doc,
	"open(bus)\n\n"
	"Connects the object to the specified SMBus.\n");

static PyObject *
SMBus_open(SMBus *self, PyObject *args, PyObject *kwds)
{
	int bus;
	char path[MAXPATH];

	static char *kwlist[] = {"bus", NULL};

	if (!PyArg_ParseTupleAndKeywords(args, kwds, "i:open", kwlist, &bus))
		return NULL;

	if (snprintf(path, MAXPATH, "/dev/i2c-%d", bus) >= MAXPATH) {
		PyErr_SetString(PyExc_OverflowError,
			"Bus number is invalid.");
		return NULL;
	}

	if ((self->fd = open(path, O_RDWR, 0)) == -1) {
		PyErr_SetFromErrno(PyExc_IOError);
		return NULL;
	}

	Py_INCREF(Py_None);
	return Py_None;
}

static int
SMBus_init(SMBus *self, PyObject *args, PyObject *kwds)
{
	int bus = -1;

	static char *kwlist[] = {"bus", NULL};

	if (!PyArg_ParseTupleAndKeywords(args, kwds, "|i:__init__",
			kwlist, &bus))
		return -1;

	if (bus >= 0) {
		SMBus_open(self, args, kwds);
		if (PyErr_Occurred())
			return -1;
	}

	return 0;
}

/*
 * private helper function, 0 => success, !0 => error
 */
static int
SMBus_set_addr(SMBus *self, int addr)
{
	int ret = 0;

	if (self->addr != addr) {
		ret = ioctl(self->fd, I2C_SLAVE, addr);
		self->addr = addr;
	}

	return ret;
}

#define SMBus_SET_ADDR(self, addr) do { \
	if (SMBus_set_addr(self, addr)) { \
		PyErr_SetFromErrno(PyExc_IOError); \
		return NULL; \
	} \
} while(0)

PyDoc_STRVAR(SMBus_write_quick_doc,
	"write_quick(addr)\n\n"
	"Perform SMBus Quick transaction.\n");

static PyObject *
SMBus_write_quick(SMBus *self, PyObject *args)
{
	int addr;
	__s32 result;

	if (!PyArg_ParseTuple(args, "i:write_quick", &addr))
		return NULL;

	SMBus_SET_ADDR(self, addr);

	if ((result = i2c_smbus_write_quick(self->fd, I2C_SMBUS_WRITE))) {
		PyErr_SetFromErrno(PyExc_IOError);
		return NULL;
	}

	Py_INCREF(Py_None);
	return Py_None;
}

PyDoc_STRVAR(SMBus_read_byte_doc,
	"read_byte(addr) -> result\n\n"
	"Perform SMBus Read Byte transaction.\n");

static PyObject *
SMBus_read_byte(SMBus *self, PyObject *args)
{
	int addr;
	__s32 result;

	if (!PyArg_ParseTuple(args, "i:read_byte", &addr))
		return NULL;

	SMBus_SET_ADDR(self, addr);

	if ((result = i2c_smbus_read_byte(self->fd)) == -1) {
		PyErr_SetFromErrno(PyExc_IOError);
		return NULL;
	}

	return Py_BuildValue("l", (long)result);
}

PyDoc_STRVAR(SMBus_write_byte_doc,
	"write_byte(addr, val)\n\n"
	"Perform SMBus Write Byte transaction.\n");

static PyObject *
SMBus_write_byte(SMBus *self, PyObject *args)
{
	int addr, val;
	__s32 result;

	if (!PyArg_ParseTuple(args, "ii:write_byte", &addr, &val))
		return NULL;

	SMBus_SET_ADDR(self, addr);

	if ((result = i2c_smbus_write_byte(self->fd, (__u8)val)) == -1) {
		PyErr_SetFromErrno(PyExc_IOError);
		return NULL;
	}

	Py_INCREF(Py_None);
	return Py_None;
}

PyDoc_STRVAR(SMBus_read_byte_data_doc,
	"read_byte_data(addr, cmd) -> result\n\n"
	"Perform SMBus Read Byte Data transaction.\n");

static PyObject *
SMBus_read_byte_data(SMBus *self, PyObject *args)
{
	int addr, cmd;
	__s32 result;

	if (!PyArg_ParseTuple(args, "ii:read_byte_data", &addr, &cmd))
		return NULL;

	SMBus_SET_ADDR(self, addr);

	if ((result = i2c_smbus_read_byte_data(self->fd, (__u8)cmd)) == -1) {
		PyErr_SetFromErrno(PyExc_IOError);
		return NULL;
	}

	return Py_BuildValue("l", (long)result);
}

PyDoc_STRVAR(SMBus_write_byte_data_doc,
	"write_byte_data(addr, cmd, val)\n\n"
	"Perform SMBus Write Byte Data transaction.\n");

static PyObject *
SMBus_write_byte_data(SMBus *self, PyObject *args)
{
	int addr, cmd, val;
	__s32 result;

	if (!PyArg_ParseTuple(args, "iii:write_byte_data", &addr, &cmd, &val))
		return NULL;

	SMBus_SET_ADDR(self, addr);

	if ((result = i2c_smbus_write_byte_data(self->fd,
				(__u8)cmd, (__u8)val)) == -1) {
		PyErr_SetFromErrno(PyExc_IOError);
		return NULL;
	}

	Py_INCREF(Py_None);
	return Py_None;
}

PyDoc_STRVAR(SMBus_read_word_data_doc,
	"read_word_data(addr, cmd) -> result\n\n"
	"Perform SMBus Read Word Data transaction.\n");

static PyObject *
SMBus_read_word_data(SMBus *self, PyObject *args)
{
	int addr, cmd;
	__s32 result;

	if (!PyArg_ParseTuple(args, "ii:read_word_data", &addr, &cmd))
		return NULL;

	SMBus_SET_ADDR(self, addr);

	if ((result = i2c_smbus_read_word_data(self->fd, (__u8)cmd)) == -1) {
		PyErr_SetFromErrno(PyExc_IOError);
		return NULL;
	}

	return Py_BuildValue("l", (long)result);
}

PyDoc_STRVAR(SMBus_write_word_data_doc,
	"write_word_data(addr, cmd, val)\n\n"
	"Perform SMBus Write Word Data transaction.\n");

static PyObject *
SMBus_write_word_data(SMBus *self, PyObject *args)
{
	int addr, cmd, val;
	__s32 result;

	if (!PyArg_ParseTuple(args, "iii:write_word_data", &addr, &cmd, &val))
		return NULL;

	SMBus_SET_ADDR(self, addr);

	if ((result = i2c_smbus_write_word_data(self->fd,
				(__u8)cmd, (__u16)val)) == -1) {
		PyErr_SetFromErrno(PyExc_IOError);
		return NULL;
	}

	Py_INCREF(Py_None);
	return Py_None;
}

PyDoc_STRVAR(SMBus_process_call_doc,
	"process_call(addr, cmd, val)\n\n"
	"Perform SMBus Process Call transaction.\n");

static PyObject *
SMBus_process_call(SMBus *self, PyObject *args)
{
	int addr, cmd, val;
	__s32 result;

	if (!PyArg_ParseTuple(args, "iii:process_call", &addr, &cmd, &val))
		return NULL;

	SMBus_SET_ADDR(self, addr);

	if ((result = i2c_smbus_process_call(self->fd,
				(__u8)cmd, (__u16)val)) == -1) {
		PyErr_SetFromErrno(PyExc_IOError);
		return NULL;
	}

	Py_INCREF(Py_None);
	return Py_None;
}

/*
 * private helper function; returns a new list of integers
 */
static PyObject *
SMBus_buf_to_list(__u8 const *buf, int len)
{
	PyObject *list = PyList_New(len);
	int ii;

	if (list == NULL)
		return NULL;

	for (ii = 0; ii < len; ii++) {
		PyObject *val = Py_BuildValue("l", (long)buf[ii]);
		PyList_SET_ITEM(list, ii, val);
	}
	return list;
}

PyDoc_STRVAR(SMBus_read_block_data_doc,
	"read_block_data(addr, cmd) -> results\n\n"
	"Perform SMBus Read Block Data transaction.\n");

static PyObject *
SMBus_read_block_data(SMBus *self, PyObject *args)
{
	int addr, cmd;
	union i2c_smbus_data data;

	if (!PyArg_ParseTuple(args, "ii:read_block_data", &addr, &cmd))
		return NULL;

	SMBus_SET_ADDR(self, addr);

	/* save a bit of code by calling the access function directly */
	if (i2c_smbus_access(self->fd, I2C_SMBUS_READ, (__u8)cmd,
				I2C_SMBUS_BLOCK_DATA, &data)) {
		PyErr_SetFromErrno(PyExc_IOError);
		return NULL;
	}

	/* first byte of the block contains (remaining) data length */
	return SMBus_buf_to_list(&data.block[1], data.block[0]);
}

/*
 * private helper function: convert an integer list to union i2c_smbus_data
 */
static int
SMBus_list_to_data(PyObject *list, union i2c_smbus_data *data)
{
	static char *msg = "Third argument must be a list of at least one, "
				"but not more than 32 integers";
	int ii, len;

	if (!PyList_Check(list)) {
		PyErr_SetString(PyExc_TypeError, msg);
		return 0; /* fail */
	}

	if ((len = PyList_GET_SIZE(list)) > 32) {
		PyErr_SetString(PyExc_OverflowError, msg);
		return 0; /* fail */
	}

	/* first byte is the length */
	data->block[0] = (__u8)len;

	for (ii = 0; ii < len; ii++) {
		PyObject *val = PyList_GET_ITEM(list, ii);
		if (!PyLong_Check(val)) {
			PyErr_SetString(PyExc_TypeError, msg);
			return 0; /* fail */
		}
		data->block[ii+1] = (__u8)PyLong_AS_LONG(val);
	}

	return 1; /* success */
}

PyDoc_STRVAR(SMBus_write_block_data_doc,
	"write_block_data(addr, cmd, [vals])\n\n"
	"Perform SMBus Write Block Data transaction.\n");

static PyObject *
SMBus_write_block_data(SMBus *self, PyObject *args)
{
	int addr, cmd;
	union i2c_smbus_data data;

	if (!PyArg_ParseTuple(args, "iiO&:write_block_data", &addr, &cmd,
				SMBus_list_to_data, &data))
		return NULL;

	SMBus_SET_ADDR(self, addr);

	/* save a bit of code by calling the access function directly */
	if (i2c_smbus_access(self->fd, I2C_SMBUS_WRITE, (__u8)cmd,
				I2C_SMBUS_BLOCK_DATA, &data)) {
		PyErr_SetFromErrno(PyExc_IOError);
		return NULL;
	}

	Py_INCREF(Py_None);
	return Py_None;
}

PyDoc_STRVAR(SMBus_block_process_call_doc,
	"block_process_call(addr, cmd, [vals]) -> results\n\n"
	"Perform SMBus Block Process Call transaction.\n");

static PyObject *
SMBus_block_process_call(SMBus *self, PyObject *args)
{
	int addr, cmd;
	union i2c_smbus_data data;

	if (!PyArg_ParseTuple(args, "iiO&:block_process_call", &addr, &cmd,
			SMBus_list_to_data, &data))
		return NULL;

	SMBus_SET_ADDR(self, addr);

	/* save a bit of code by calling the access function directly */
	if (i2c_smbus_access(self->fd, I2C_SMBUS_WRITE, (__u8)cmd,
				I2C_SMBUS_BLOCK_PROC_CALL, &data)) {
		PyErr_SetFromErrno(PyExc_IOError);
		return NULL;
	}

	/* first byte of the block contains (remaining) data length */
	return SMBus_buf_to_list(&data.block[1], data.block[0]);
}

PyDoc_STRVAR(SMBus_read_i2c_block_data_doc,
	"read_i2c_block_data(addr, cmd, len=32) -> results\n\n"
	"Perform I2C Block Read transaction.\n");

static PyObject *
SMBus_read_i2c_block_data(SMBus *self, PyObject *args)
{
	int addr, cmd, len=32;
	union i2c_smbus_data data;

	if (!PyArg_ParseTuple(args, "ii|i:read_i2c_block_data", &addr, &cmd,
			&len))
		return NULL;

	SMBus_SET_ADDR(self, addr);

	data.block[0] = len;
	/* save a bit of code by calling the access function directly */
	if (i2c_smbus_access(self->fd, I2C_SMBUS_READ, (__u8)cmd,
				len == 32 ? I2C_SMBUS_I2C_BLOCK_BROKEN:
				I2C_SMBUS_I2C_BLOCK_DATA, &data)) {
		PyErr_SetFromErrno(PyExc_IOError);
		return NULL;
	}

	/* first byte of the block contains (remaining) data length */
	return SMBus_buf_to_list(&data.block[1], data.block[0]);
}

PyDoc_STRVAR(SMBus_write_i2c_block_data_doc,
	"write_i2c_block_data(addr, cmd, [vals])\n\n"
	"Perform I2C Block Write transaction.\n");

static PyObject *
SMBus_write_i2c_block_data(SMBus *self, PyObject *args)
{
	int addr, cmd;
	union i2c_smbus_data data;

	if (!PyArg_ParseTuple(args, "iiO&:write_i2c_block_data", &addr, &cmd,
			SMBus_list_to_data, &data))
		return NULL;

	SMBus_SET_ADDR(self, addr);

	/* save a bit of code by calling the access function directly */
	if (i2c_smbus_access(self->fd, I2C_SMBUS_WRITE, (__u8)cmd,
				I2C_SMBUS_I2C_BLOCK_BROKEN, &data)) {
		PyErr_SetFromErrno(PyExc_IOError);
		return NULL;
	}

	Py_INCREF(Py_None);
	return Py_None;
}

PyDoc_STRVAR(SMBus_type_doc,
	"SMBus([bus]) -> SMBus\n\n"
	"Return a new SMBus object that is (optionally) connected to the\n"
	"specified I2C device interface.\n");

static PyMethodDef SMBus_methods[] = {
	{"open", (PyCFunction)SMBus_open, METH_VARARGS | METH_KEYWORDS,
		SMBus_open_doc},
	{"close", (PyCFunction)SMBus_close, METH_NOARGS,
		SMBus_close_doc},
	{"write_quick", (PyCFunction)SMBus_write_quick, METH_VARARGS,
		SMBus_write_quick_doc},
	{"read_byte", (PyCFunction)SMBus_read_byte, METH_VARARGS,
		SMBus_read_byte_doc},
	{"write_byte", (PyCFunction)SMBus_write_byte, METH_VARARGS,
		SMBus_write_byte_doc},
	{"read_byte_data", (PyCFunction)SMBus_read_byte_data, METH_VARARGS,
		SMBus_read_byte_data_doc},
	{"write_byte_data", (PyCFunction)SMBus_write_byte_data, METH_VARARGS,
		SMBus_write_byte_data_doc},
	{"read_word_data", (PyCFunction)SMBus_read_word_data, METH_VARARGS,
		SMBus_read_word_data_doc},
	{"write_word_data", (PyCFunction)SMBus_write_word_data, METH_VARARGS,
		SMBus_write_word_data_doc},
	{"process_call", (PyCFunction)SMBus_process_call, METH_VARARGS,
		SMBus_process_call_doc},
	{"read_block_data", (PyCFunction)SMBus_read_block_data, METH_VARARGS,
		SMBus_read_block_data_doc},
	{"write_block_data", (PyCFunction)SMBus_write_block_data, METH_VARARGS,
		SMBus_write_block_data_doc},
	{"block_process_call", (PyCFunction)SMBus_block_process_call,
		METH_VARARGS, SMBus_block_process_call_doc},
	{"read_i2c_block_data", (PyCFunction)SMBus_read_i2c_block_data,
		METH_VARARGS, SMBus_read_i2c_block_data_doc},
	{"write_i2c_block_data", (PyCFunction)SMBus_write_i2c_block_data,
		METH_VARARGS, SMBus_write_i2c_block_data_doc},
	{NULL},
};

static PyObject *
SMBus_get_pec(SMBus *self, void *closure)
{
	PyObject *result = self->pec ? Py_True : Py_False;
	Py_INCREF(result);
	return result;
}

static int
SMBus_set_pec(SMBus *self, PyObject *val, void *closure)
{
	int pec;

	pec = PyObject_IsTrue(val);

	if (val == NULL) {
		PyErr_SetString(PyExc_TypeError,
			"Cannot delete attribute");
		return -1;
	}
	else if (pec == -1) {
		PyErr_SetString(PyExc_TypeError,
			"The pec attribute must be a boolean.");
		return -1;
	}

	if (self->pec != pec) {
		if (ioctl(self->fd, I2C_PEC, pec)) {
			PyErr_SetFromErrno(PyExc_IOError);
			return -1;
		}
		self->pec = pec;
	}

	return 0;
}

static PyGetSetDef SMBus_getset[] = {
	{"pec", (getter)SMBus_get_pec, (setter)SMBus_set_pec,
			"True if Packet Error Codes (PEC) are enabled"},
	{NULL},
};

/* old Python 2.7 declaration */
static PyTypeObject SMBus_type = {
/*tatic struct PyModuleDef SMBus_type = {*/
    /* old Python 2.7 declaration */
	/* PyObject_HEAD_INIT(NULL) */
	/*0,				 ob_size */
	PyVarObject_HEAD_INIT(NULL, 0)
	"SMBus",			/* tp_name */
	sizeof(SMBus),		/* tp_basicsize */
	0,				    /* tp_itemsize */
	(destructor)SMBus_dealloc,	/* tp_dealloc */
	0,				/* tp_print */
	0,				/* tp_getattr */
	0,				/* tp_setattr */
	0,				/* tp_compare */
	0,				/* tp_repr */
	0,				/* tp_as_number */
	0,				/* tp_as_sequence */
	0,				/* tp_as_mapping */
	0,				/* tp_hash */
	0,				/* tp_call */
	0,				/* tp_str */
	0,				/* tp_getattro */
	0,				/* tp_setattro */
	0,				/* tp_as_buffer */
	Py_TPFLAGS_DEFAULT, /* tp_flags */
	SMBus_type_doc,		/* tp_doc */
	0,				/* tp_traverse */
	0,				/* tp_clear */
	0,				/* tp_richcompare */
	0,				/* tp_weaklistoffset */
	0,				/* tp_iter */
	0,				/* tp_iternext */
	SMBus_methods,	/* tp_methods */
	0,              /* tp_members */
	SMBus_getset,	/* tp_getset */
	0,				/* tp_base */
	0,				/* tp_dict */
	0,				/* tp_descr_get */
	0,				/* tp_descr_set */
	0,				/* tp_dictoffset */
	(initproc)SMBus_init,   /* tp_init */
	0,				/* tp_alloc */
	SMBus_new,		/* tp_new */
};

/*static PyMethodDef SMBus_module_methods[] = {
	{NULL}
};*/

static struct PyModuleDef SMBusModule = {
        PyModuleDef_HEAD_INIT,
        "SMBus",     /* m_name */
        "This module defines an object type that allows SMBus transactions\n"
	    "on hosts running the Linux kernel.  The host kernel must have I2C\n"
	    "support, I2C device interface support, and a bus adapter driver.\n"
	    "All of these can be either built-in to the kernel, or loaded from\n"
	    "modules.\n"
	    "\n"
	    "Because the I2C device interface is opened R/W, users of this\n"
	    "module usually must have root permissions.\n",  /* m_doc */
        -1,                  /* m_size */
        NULL,    /* m_methods */
        NULL,                /* m_reload */
        NULL,                /* m_traverse */
        NULL,                /* m_clear */
        NULL,                /* m_free */
    };

#ifndef PyMODINIT_FUNC	/* declarations for DLL import/export */
#define PyMODINIT_FUNC void
#endif
PyMODINIT_FUNC
PyInit_smbus(void)
{
	PyObject* m;

    if (PyType_Ready(&SMBus_type) < 0)
		return NULL;

    /* old Python 2.7 declaration */
	/*m = Py_InitModule3("smbus", SMBus_module_methods, SMBus_module_doc);*/
	m = PyModule_Create(&SMBusModule);
	
    if (m == NULL)
        return NULL;

	Py_INCREF(&SMBus_type);
	PyModule_AddObject(m, "SMBus", (PyObject *)&SMBus_type);
	
	return m;
}




-----Original Message-----
From: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org [mailto:linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org] On Behalf Of Renz, Bernhard
Sent: Monday, 14 May, 2012 13:16
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Subject: Howto compile py-smbus with python 3.2

Hello @All,

i try to compile i2c-tools-3.1.0 py-smbus, smbusmodule.c with the following command under Ubuntu 12.04:
python3.2 ./setup.py build

But it fail with the following errors:
running build
running build_ext
building 'smbus' extension
gcc -pthread -DNDEBUG -g -fwrapv -O2 -Wall -Wstrict-prototypes -g -fstack-protector --param=ssp-buffer-size=4 -Wformat -Wformat-security -Werror=format-security -fPIC -I/usr/include/python3.2mu -c smbusmodule.c -o build/temp.linux-x86_64-3.2/smbusmodule.o



smbusmodule.c: In function 'SMBus_dealloc':
smbusmodule.c:94:6: error: 'SMBus' has no member named 'ob_type'
smbusmodule.c: In function 'SMBus_list_to_data':

With Python 2.7 it works. So it seems that the smbusmodule.c is written for Python 2.7.
I googled a bit, and found the following article where the changes in the c extentation between Python 2.X and Python 3 is described (espancially the ob_type problem):
http://python3porting.com/cextensions.html

Citation:
Another change in the object header is that the PyObject_HEAD macro has changed so that ob_type is now in a nested structure. This means you no longer can pick the ob_type directly from the struct, so code like ob->ob_type stops working. You should replace this with Py_TYPE(ob). The Py_TYPE macro doesn't appear until Python 2.6, so to support earlier versions we make another #ifndef:
#ifndef Py_TYPE
    #define Py_TYPE(ob) (((PyObject*)(ob))->ob_type) #endif In both cases the definitions above are taken directly from the Python 2.6 headers, where they are defined for forward compatibility purposes with Python 3. They work well in earlier Python versions as well, so this is a trick you can use as a general rule; if you need to use a macro that is defined in Python 3 and Python 2.6, just steal the Python 2.6 or Python 2.7 definition and put it inside an #ifndef.


Has anybody smbusmodule.c port to use with python 3?

With kind regards
Bernhard


________________________________
The information contained in this message may be confidential and legally protected under applicable law. The message is intended solely for the addressee(s). If you are not the intended recipient, you are hereby notified that any use, forwarding, dissemination, or reproduction of this message is strictly prohibited and may be unlawful. If you are not the intended recipient, please contact the sender by return e-mail and destroy all copies of the original message.

--
To unsubscribe from this list: send the line "unsubscribe linux-i2c" in the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org More majordomo info at  http://vger.kernel.org/majordomo-info.html
