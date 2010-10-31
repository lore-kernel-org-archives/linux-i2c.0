From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 2/2] i2c-i801: Add PCI idents for Patsburg 'IDF' SMBus
 controllers
Date: Sun, 31 Oct 2010 21:11:59 +0100
Message-ID: <20101031211159.0766e5f2@endymion.delvare>
References: <1288538652.4570.52.camel@macbook.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1288538652.4570.52.camel-uXGAPMMVk8bAQYKIod7YupZV94DADvEd@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Sun, 31 Oct 2010 11:24:12 -0400, David Woodhouse wrote:
> These are the extra 'Integrated Device Function' SMBus controllers found
> on the Patsburg chipset. Mention the absence of slave mode support.
> 
> Signed-off-by: David Woodhouse <David.Woodhouse-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> ---
> Seth already added the host controller ID, calling it 'Patsburg'. So
> I'll call it 'Patsburg' too, and just add the additional controllers.

Applied, thanks.

> 
> We should probably add a column in the hardware support table indicating
> which devices support slave mode. The Patsburg host does; the IDF
> controllers don't. Not sure how many older devices have slave mode.

I agree. Feel free to only add the yes/no flag in that column for the
devices for which you know the answer, and we can populate the rest
later. All the datasheets are available so it should be doable although
this will take some time due to the large number of supported devices.

That being said, this column will really only start being interesting
if/when we actually implement support for the slave mode. Not sure who
needs this.

-- 
Jean Delvare
