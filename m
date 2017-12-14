From: Randy Dunlap <rdunlap-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Subject: Re: [PATCH v2 6/7] i3c: master: Add driver for Cadence IP
Date: Thu, 14 Dec 2017 14:10:06 -0800
Message-ID: <3ea7ec44-3cf7-9f2f-c6e2-161fad939aa3@infradead.org>
References: <20171214151610.19153-1-boris.brezillon@free-electrons.com>
 <20171214151610.19153-7-boris.brezillon@free-electrons.com>
 <d0685c1d-a3ed-b3c1-7e3f-b69b02e8a7be@infradead.org>
 <20171214211722.1c2f269d@bbrezillon>
 <8245f2de-eb0a-319b-8f45-d8d5dac36239@infradead.org>
 <20171214214442.55902041@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171214214442.55902041@bbrezillon>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Przemyslaw Sroka <psroka-vna1KIf7WgpBDgjK7y7TUQ@public.gmane.org>, Arkadiusz Golec <agolec-vna1KIf7WgpBDgjK7y7TUQ@public.gmane.org>, Alan Douglas <adouglas-vna1KIf7WgpBDgjK7y7TUQ@public.gmane.org>, Bartosz Folta <bfolta-vna1KIf7WgpBDgjK7y7TUQ@public.gmane.org>, Damian Kos <dkos-vna1KIf7WgpBDgjK7y7TUQ@public.gmane.org>, Alicja Jurasik-Urbaniak <alicja-vna1KIf7WgpBDgjK7y7TUQ@public.gmane.org>, Cyprian Wronka <cwronka-vna1KIf7WgpBDgjK7y7TUQ@public.gmane.org>, Suresh Punnoose <sureshp-vna1KIf7WgpBDgjK7y7TUQ@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak@co>
List-Id: linux-i2c@vger.kernel.org

On 12/14/2017 12:44 PM, Boris Brezillon wrote:
> On Thu, 14 Dec 2017 12:25:14 -0800
> Randy Dunlap <rdunlap-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org> wrote:
> 
>> On 12/14/2017 12:17 PM, Boris Brezillon wrote:
>>>>> +	events.events = I3C_CCC_EVENT_HJ | I3C_CCC_EVENT_MR;
>>>>> +	ret = i3c_master_enec_locked(m, I3C_BROADCAST_ADDR, &events);
>>>>> +	if (ret)
>>>>> +		pr_info("Failed to re-enable H-J");    
>>>> 		Not very good info...  
>>> What do you mean? Is it the H-J that bothers you (I can replace it by
>>> 'Hot-Join'), or is it something else?  
>>
>> Who is the message for?  If it's for developers, you could use
>> pr_debug().  If it's for users, it needs more clarity.
> 
> I think it's of interest to anyone including users. If we fail to
> re-enable Hot-Join that means hotplug is no longer working which is
> a bad news.
> 
>>
>> Does it print the source of the message? (module name e.g.)
> 
> I could replace it by
> 
> 	dev_err(m->parent, "Failed to re-enable Hot-Join");
> 

Yes, that's a good plan.

Thanks.

> 
> 
>> and yes, Hot-Join would be better IMO.


-- 
~Randy
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
