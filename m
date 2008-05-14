From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [patch 2.6.25-git] i2c_adapters:  return -Errno not -1
Date: Wed, 14 May 2008 07:50:49 -0700
Message-ID: <200805140750.49365.david-b@pacbell.net>
References: <200805012046.07885.david-b@pacbell.net>
	<200805120948.23842.david-b@pacbell.net>
	<20080514141738.327be680@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080514141738.327be680-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wednesday 14 May 2008, Jean Delvare wrote:
> 
> > Here's a patch adding such information ... against 2.6.26-rc2 and
> > in synch with both the "-Errno not -1" patches I've sent.
> 
> Thanks for doing this. This document will be very helpful both for me
> when reviewing your patches, and for both I2C bus and I2C device driver
> authors later.

Updated version.

======== CUT HERE
Create Documentation/i2c/fault-codes to help standardize
fault/error code usage in the I2C stack.  It turns out that
returning -1 (-EPERM) for everything was not at all helpful.

Signed-off-by: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
---
 Documentation/i2c/fault-codes |  127 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 127 insertions(+)

--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ g26/Documentation/i2c/fault-codes	2008-05-14 07:49:55.000000000 -0700
@@ -0,0 +1,127 @@
+This is a summary of the most important conventions for use of fault
+codes in the I2C/SMBus stack.
+
+
+A "Fault" is not always an "Error"
+----------------------------------
+Not all fault reports imply errors; "page faults" should be a familiar
+example.  Software often retries idempotent operations after transient
+faults.  There may be fancier recovery schemes that are appropriate in
+some cases, such as re-initializing (and maybe resetting).  After such
+recovery, triggered by a fault report, there is no error.
+
+In a similar way, sometimes a "fault" code just reports one defined
+result for an operation ... it doesn't indicate that anything is wrong
+at all, just that the outcome wasn't on the "golden path".
+
+In short, your I2C driver code may need to know these codes in order
+to respond correctly.  Other code may need to rely on YOUR code reporting
+the right fault code, so that it can (in turn) behave correctly.
+
+
+I2C and SMBus fault codes
+-------------------------
+These are returned as negative numbers from most calls, with zero or
+some positive number indicating a non-fault return.  The specific
+numbers associated with these symbols differ between architectures,
+though most Linux systems use <asm-generic/errno*.h> numbering.
+
+Note that the descriptions here are not exhaustive.  There are other
+codes that may be returned, and other cases where these codes should
+be returned.  However, drivers should not return other codes for these
+cases (unless the hardware doesn't provide unique fault reports).
+
+Also, codes returned by adapter probe methods follow rules which are
+specific to their host bus (such as PCI, or the platform bus).
+
+
+EAGAIN
+	Returned by I2C adapters when they lose arbitration in master
+	transmit mode:  some other master was transmitting different
+	data at the same time.
+
+	Also returned when trying to invoke an I2C operation in an
+	atomic context, when some task is already using that I2C bus
+	to execute some other operation.
+
+EBADMSG
+	Returned by SMBus logic when an invalid Packet Error Code byte
+	is received.  This code is a CRC covering all bytes in the
+	transaction, and is sent before the terminating STOP.  This
+	fault is only reported on read transactions; the SMBus slave
+	may have a way to report PEC mismatches on writes from the
+	host.  Note that even if PECs are in use, you should not rely
+	on these as the only way to detect incorrect data transfers.
+
+EBUSY
+	Returned by SMBus adapters when the bus was busy for longer
+	than allowed.  This usually indicates some device (maybe the
+	SMBus adapter) needs some fault recovery (such as resetting),
+	or that the reset was attempted but failed.
+
+EINVAL
+	This rather vague error means an invalid parameter has been
+	detected before any I/O operation was started.  Use a more
+	specific fault code when you can.
+
+	One example would be a driver trying an SMBus Block Write
+	with block size outside the range of 1-32 bytes.
+
+EIO
+	This rather vague error means something went wrong when
+	performing an I/O operation.  Use a more specific fault
+	code when you can.
+
+ENODEV
+	Returned by driver probe() methods.  This is a bit more
+	specific than ENXIO, implying the problem isn't with the
+	address, but with the device found there.  Driver probes
+	may verify the device returns *correct* responses, and
+	return this as appropriate.  (The driver core will warn
+	about probe faults other than ENXIO and ENODEV.)
+
+ENOMEM
+	Returned by any component that can't allocate memory when
+	it needs to do so.
+
+ENXIO
+	Returned by I2C adapters to indicate that the address phase
+	of a transfer didn't get an ACK.  While it might just mean
+	an I2C device was temporarily not responding, usually it
+	means there's nothing listening at that address.
+
+	Returned by driver probe() methods to indicate that they
+	found no device to bind to.  (ENODEV may also be used.)
+
+EOPNOTSUPP
+	Returned by an adapter when asked to perform an operation
+	that it doesn't, or can't, support.
+
+	For example, this would be returned when an adapter that
+	doesn't support SMBus block transfers is asked to execute
+	one.  In that case, the driver making that request should
+	have verified that functionality was supported before it
+	made that block transfer request.
+
+	Similarly, if an I2C adapter can't execute all legal I2C
+	messages, it should return this when asked to perform a
+	transaction it can't.  (These limitations can't be seen in
+	the adapter's functionality mask, since the assumption is
+	that if an adapter supports I2C it supports all of I2C.)
+
+EPROTO
+	Returned when slave does not conform to the relevant I2C
+	or SMBus (or chip-specific) protocol specifications.  One
+	case is when the length of an SMBus block data response
+	(from the SMBus slave) is outside the range 1-32 bytes.
+
+ETIMEDOUT
+	This is returned by drivers when an operation took too much
+	time, and was aborted before it completed.
+
+	SMBus adapters may return it when an operation took more
+	time than allowed by the SMBus specification; for example,
+	when a slave stretches clocks too far.  I2C has no such
+	timeouts, but it's normal for I2C adapters to impose some
+	arbitrary limits (much longer than SMBus!) too.
+


_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
