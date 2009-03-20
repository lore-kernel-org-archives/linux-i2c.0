From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [Q] i2c_new_device vs i2c_del_driver
Date: Fri, 20 Mar 2009 18:48:30 +0100
Message-ID: <20090320184830.2ee7a6f8@hyperion.delvare>
References: <Pine.LNX.4.64.0903171710350.5318@axis700.grange>
	<20090317183809.55320908@hyperion.delvare>
	<Pine.LNX.4.64.0903171849060.5318@axis700.grange>
	<20090317191724.7ace956f@hyperion.delvare>
	<Pine.LNX.4.64.0903171923230.5318@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.64.0903171923230.5318-0199iw4Nj15frtckUFj5Ag@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Guennadi,

On Tue, 17 Mar 2009 19:29:07 +0100 (CET), Guennadi Liakhovetski wrote:
> On Tue, 17 Mar 2009, Jean Delvare wrote:
> 
> > On Tue, 17 Mar 2009 18:50:50 +0100 (CET), Guennadi Liakhovetski wrote:
> > > 
> > > Aha, so, the driver->clients list will not contain my device, and it won't 
> > > get unregistered. Ic.
> > 
> > Correct. Maybe I should have found a better name, like
> > driver->detected_clients, to make it clearer. Want me to change it
> > know? It should be straightforward.
> 
> Well, now I know the difference already, but I am not sure this would have 
> helped me before you've explained it:-) So, don't bother because of me. 
> Maybe adding a couple of words to Documentation/i2c/writing-clients 
> explaining the different function i2c_del_driver() performs on different 
> devices.

Well, writing-clients is really only about writing driver code, I don't
think it is the right document to describe the i2c-core internals nor
the device lifetime.

I have recently written a new document explaining how devices can be
instantiated:
ftp://ftp.kernel.org/pub/linux/kernel/people/jdelvare/linux-2.6/jdelvare-i2c/i2c-how-to-instantiate-devices.patch
This document explains the conditions of destruction of the devices
depending on how they were created. I hope this answers your question.
If not, the document can of course be clarified.

> Or a comment in the source - even better.

For the piece of code which confused you, yes, I agree a short comment
would help. What about:

---
 drivers/i2c/i2c-core.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- linux-2.6.29-rc8.orig/drivers/i2c/i2c-core.c	2009-03-20 09:45:43.000000000 +0100
+++ linux-2.6.29-rc8/drivers/i2c/i2c-core.c	2009-03-20 17:21:29.000000000 +0100
@@ -581,7 +581,8 @@ static int i2c_do_del_adapter(struct dev
 	struct i2c_client *client, *_n;
 	int res;
 
-	/* Remove the devices we created ourselves */
+	/* Remove the devices we created ourselves as the result of hardware
+	 * probing (using a driver's detect method) */
 	list_for_each_entry_safe(client, _n, &driver->clients, detected) {
 		if (client->adapter == adapter) {
 			dev_dbg(&adapter->dev, "Removing %s at 0x%x\n",
@@ -749,6 +750,8 @@ static int __detach_adapter(struct devic
 	struct i2c_driver *driver = data;
 	struct i2c_client *client, *_n;
 
+	/* Remove the devices we created ourselves as the result of hardware
+	 * probing (using a driver's detect method) */
 	list_for_each_entry_safe(client, _n, &driver->clients, detected) {
 		dev_dbg(&adapter->dev, "Removing %s at 0x%x\n",
 			client->name, client->addr);


-- 
Jean Delvare
