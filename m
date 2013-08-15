From: Jussi Kivilinna <jussi.kivilinna-X3B1VOXEql0@public.gmane.org>
Subject: Re: [PATCH] i2c-tiny-usb: do not use stack as URB transfer_buffer
Date: Thu, 15 Aug 2013 22:46:32 +0300
Message-ID: <520D3018.3000709@iki.fi>
References: <20130806111742.25265.94046.stgit@localhost6.localdomain6> <20130815175550.GA5934@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130815175550.GA5934@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Till Harbaum <till-RcHadlBFbzVAfugRpC6u6w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On 15.08.2013 20:55, Wolfram Sang wrote:
> On Tue, Aug 06, 2013 at 02:17:42PM +0300, Jussi Kivilinna wrote:
>> Patch fixes i2c-tiny-usb not to use stack as URB transfer_buffer. URB buffers
>> need to be DMA-able, which stack is not.
>>
>> Patch is only compile tested.
>>
>> Cc: stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>> Signed-off-by: Jussi Kivilinna <jussi.kivilinna-X3B1VOXEql0@public.gmane.org>
> 
> Looks OK to me. Till, are you there?

That cc to stable should probably be removed if patch is not tested on hw.

-Jussi
