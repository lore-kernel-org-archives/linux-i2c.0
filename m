From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] i2c: convert struct i2c_msg initialization to C99
 format
Date: Fri, 3 Aug 2012 16:14:49 +0200
Message-ID: <20120803161449.5dbb3295@endymion.delvare>
References: <1343994924-2341-1-git-send-email-shubhrajyoti@ti.com>
	<20120803151412.0cb16ed6@endymion.delvare>
	<CANQgH-bmTdZ1z=Vbeg07mZ-FLRBrzhuf+Wz1Uv2GcU2dWW9TGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CANQgH-bmTdZ1z=Vbeg07mZ-FLRBrzhuf+Wz1Uv2GcU2dWW9TGA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Datta, Shubhrajyoti" <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Fri, 3 Aug 2012 19:09:33 +0530, Datta, Shubhrajyoti wrote:
> On Fri, Aug 3, 2012 at 6:44 PM, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> wrote:
> > Good idea but I see no good reason to switch from struct-wide
> > initialization to per-field initialization. AFAIK per-field
> > initialization is less efficient and might leave some fields
> > uninitialized, while I seem to remember struct-wide initialization sets
> > them to 0.
> in case of locals also?

I _think_ so... But I admit I would be unable to quote the C99 standard
on that. If someone knows for sure, please speak up.

-- 
Jean Delvare
