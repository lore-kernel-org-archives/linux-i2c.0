From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH RFC] Splitting i2c-designware.c to support PCI drivers
Date: Tue, 18 Jan 2011 13:15:46 +0100
Message-ID: <20110118131546.0ae6ea9e@endymion.delvare>
References: <1295033256-30077-1-git-send-email-dirk.brandewie@gmail.com>
	<20110114213007.58c8b237@endymion.delvare>
	<20110114214839.GC15795@trinity.fluff.org>
	<4D346909.6030503@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4D346909.6030503-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dirk Brandewie <dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, shinya.kuribayashi.px-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Dirk,

On Mon, 17 Jan 2011 08:06:33 -0800, Dirk Brandewie wrote:
> On 01/14/2011 01:48 PM, Ben Dooks wrote:
> > On Fri, Jan 14, 2011 at 09:30:07PM +0100, Jean Delvare wrote:
> >> Hi Dirk,
> >>
> >> On Fri, 14 Jan 2011 11:27:27 -0800, dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org wrote:
> >>> From: Dirk Brandewie<dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> >>>
> >>> This patch set splits i2c-designware.c core and bus specific portions
> >>> in to support the Designware core being behind a PCI device.
> >>>
> >>> The Intel Moorsetown and Medfield SOC's are supported in the PCI
> >>> portion of the driver.
> >>
> >> We already have the i2c-intel-mid driver for Moorsetown and Medfield.
> >> Why would we need another driver?
> 
> I was tasked with fixing a couple of bugs i2c-intel-mid.c and adding support for 
> another upcoming platform.  While I was coming up to speed on the driver I 
> "discovered" the i2c-designware.c driver.  After talking with AlanC and Shinya 
> it seemed like the right thing to do to merge the two drivers.  The patch set 
> adds a parallel driver ATM moment until it get some good test.  Once it gets 
> more test I plan on adding patches to remove i2c-intel-mid.c and update current 
> i2c-designware.c driver to use the merged driver.

OK, this makes a lot of sense then. You should have explained that
right away!

-- 
Jean Delvare
