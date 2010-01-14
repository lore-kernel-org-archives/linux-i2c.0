From: Shinya Kuribayashi <shinya.kuribayashi-jaWZhaxaiAMAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 0/3] i2c-designware: Allow mixed endianness
Date: Thu, 14 Jan 2010 09:40:53 +0900
Message-ID: <4B4E6815.9050908@necel.com>
References: <20100113193224.753273000@octasic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100113193224.753273000-YGVykHU+fedBDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean-Hugues Deschenes <jean-hugues.deschenes-YGVykHU+fedBDgjK7y7TUQ@public.gmane.org>
Cc: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Jean-Hugues Deschenes wrote:
> Here is patchset for the i2c-designware driver, allowing little
> endian  machines to use the DW IP instantiated in big endian
> and vice versa.

In the commit ed5e1dd5 (i2c-designware: Consolidate to use 32-bit
word accesses), I tried to sort out the I/O endian issue, but it
seems doesn't work for your environment, R/W data is swapped :-(

-- 
Shinya Kuribayashi
NEC Electronics
