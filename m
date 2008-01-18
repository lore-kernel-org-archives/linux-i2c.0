From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: i2c-remove-redundant-i2c_client-list.patch
Date: Fri, 18 Jan 2008 13:10:05 +0100
Message-ID: <20080118131005.76713d41@hyperion.delvare>
References: <20071216052308.A0FB11668D7@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
	<200801171159.00291.david-b@pacbell.net>
	<20080118103209.4b92ac76@hyperion.delvare>
	<200801180216.22363.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <200801180216.22363.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Cc: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi David,

On Fri, 18 Jan 2008 02:16:22 -0800, David Brownell wrote:
> On Friday 18 January 2008, Jean Delvare wrote:
> > This gave me the idea of a similar cleanup in i2c_detach_client: I fail
> > to see why we hold the clist lock while unregistering the device. What
> > do you think of the following cleanup?
> 
> Looks OK.  Similarly, i2c_new_probed_device() could
> use a driver model iterator instead of clist_lock.

I'm not sure I follow you here. i2c_new_probed_device() doesn't really
walk the list of clients, all it does is calling i2c_check_addr(), as
was discussed elsewhere in this thread. This left apart, I don't see
what kind of "driver model iterator" you would want to use in this
function.

> Something else to think about:  clist_lock isn't used
> when iterating over i2c_adapter.clients.  Maybe it should
> just be removed, and replaced *everywhere* by core_lists...

I don't really want to do that. The redundant client list will be
dropped at some point in time, and it's easier to validate such changes
with dedicated locks. Having a single lock for many things makes it
quite hard to figure out what was being protected after the fact.

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
