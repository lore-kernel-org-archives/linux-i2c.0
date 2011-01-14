From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH RFC] Splitting i2c-designware.c to support PCI drivers
Date: Fri, 14 Jan 2011 21:30:07 +0100
Message-ID: <20110114213007.58c8b237@endymion.delvare>
References: <1295033256-30077-1-git-send-email-dirk.brandewie@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1295033256-30077-1-git-send-email-dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, shinya.kuribayashi.px-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Dirk,

On Fri, 14 Jan 2011 11:27:27 -0800, dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org wrote:
> From: Dirk Brandewie <dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> 
> This patch set splits i2c-designware.c core and bus specific portions
> in to support the Designware core being behind a PCI device.
> 
> The Intel Moorsetown and Medfield SOC's are supported in the PCI
> portion of the driver.

We already have the i2c-intel-mid driver for Moorsetown and Medfield.
Why would we need another driver?

-- 
Jean Delvare
