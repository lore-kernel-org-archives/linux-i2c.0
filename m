From: Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3 1/4] i2c: mux-pinctrl: Rework to honor disabled child
 nodes
Date: Sun, 22 Mar 2015 14:03:56 +0100
Message-ID: <550EBDBC.9000903@gmail.com>
References: <1425903665-19343-1-git-send-email-sebastian.hesselbarth@gmail.com> <20150318123012.GA3580@katana> <55097C46.9010605@gmail.com> <20150318140037.GE3580@katana> <550A05E5.3050100@gmail.com> <20150319100944.GA914@katana> <550AEF9D.6090307@wwwdotorg.org> <20150319160208.GF7657@katana> <550B3725.10209@gmail.com> <20150320101925.GC2071@katana> <20150321210028.GA1078@katana>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150321210028.GA1078@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Gregory Clement <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Gabriel Dobato <dobatog-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 21.03.2015 22:00, Wolfram Sang wrote:
>>> I guess what you want to have is that i2c_add_adapter() is not called
>>> for the disabled case, right?
>>
>> I think that makes sense.
>
> But maybe we should just start simple and keep calling i2c_add_adapter()
> for the disabled case. We will just skip probing devices on the bus.
> Would that help the issue you were originally trying to solve?

It is not about probing devices on the mux sub-busses, I'd expect no
devices on the optional sub-busses in DT on boards where those pins
are not used as i2c.

The idea was to hide those busses completely in particular from
userspace on boards where they'll never be available.

If modifying i2c-mux-pinctrl to respect the sub-bus status property is
such a big issue, I'd rather leave the driver as is and expose all
sub-busses to userspace.

Sebastian
