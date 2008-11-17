From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: wrong driver remove order
Date: Mon, 17 Nov 2008 22:04:17 +0100
Message-ID: <20081117220417.0d83443c@hyperion.delvare>
References: <Pine.LNX.4.64.0810301509380.5463@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.64.0810301509380.5463-0199iw4Nj15frtckUFj5Ag@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Guennadi,

On Thu, 30 Oct 2008 15:13:14 +0100 (CET), Guennadi Liakhovetski wrote:
> Hi,
> 
> I have two i2c modules, one of which uses the other one: a camera and a 
> GPIO-extender, and the camera uses a GPIO from that extender. I first load 
> the GPIO-extender driver (pca953x.c), then the camera (mt9m001.c), then as 
> I tried to remove the bus driver (i2c-mxc, not yet in the mainline), first 
> the GPIO-extender's .remove() method has been called, which, of course, 
> failed, because mt9m001 was still holding its GPIO... AFAIU, the remove 
> order should be reverse from probe, right?

It would indeed make sense for the removal order to be the reverse of
the bind order. Can you please try the following patch and report if it
solves your problem?

From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: i2c: Remove i2c clients in reverse order

i2c clients should be removed in reverse order compared to the probe
(actually: bind) order. This matters when several clients depend on
each other.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>
---
 drivers/i2c/i2c-core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.28-rc5.orig/drivers/i2c/i2c-core.c	2008-11-17 21:29:59.000000000 +0100
+++ linux-2.6.28-rc5/drivers/i2c/i2c-core.c	2008-11-17 21:44:06.000000000 +0100
@@ -631,7 +631,7 @@ int i2c_del_adapter(struct i2c_adapter *
 
 	/* detach any active clients. This must be done first, because
 	 * it can fail; in which case we give up. */
-	list_for_each_entry_safe(client, _n, &adap->clients, list) {
+	list_for_each_entry_safe_reverse(client, _n, &adap->clients, list) {
 		struct i2c_driver	*driver;
 
 		driver = client->driver;


-- 
Jean Delvare
