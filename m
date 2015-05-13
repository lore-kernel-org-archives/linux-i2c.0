From: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH 1/2] i2c: core: Remove needless structure member zero
 initialization
Date: Wed, 13 May 2015 09:10:28 +0300
Message-ID: <5552EAD4.7070806@linux.intel.com>
References: <1430311477-21759-1-git-send-email-jarkko.nikula@linux.intel.com> <20150512190348.GA4449@schokonusskuchen.bad>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150512190348.GA4449-oo5tB6JMkjKRinMKxDlMNPwbnWRJjS81@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 05/12/2015 10:03 PM, Wolfram Sang wrote:
> On Wed, Apr 29, 2015 at 03:44:36PM +0300, Jarkko Nikula wrote:
>> No need to clear one struct i2c_client member variable since memset has
>> already cleared all of them. Remove also one space intendation from err
>> label.
>
> Ehrm, why change this now when you remove the code block in the next
> patch anyhow? :)
>
Actually second patch is not removing any other code blocks than memset 
so my 2 seconds thinking said lets put that client.flags = 0; removal to 
another patch especially after finding the err label indentation, i.e. 
spring cleanings first and then the actual patch :-)

> Also, the indentation thing is very likely intentional. Sadly, I can't
> remember why at this moment, but I remember that when I tried to grep
> something I understood why some people put a space in front of labels
>
Probably it makes code look better in some cases when there are multiple 
labels but here it didn't look consistent with the rest of the file.

I don't mind squashing this into second patch or keep them separate. I'd 
like to resend anyway because I noticed s/intendation/indentation/ 
misspelling in the commit log here.

-- 
Jarkko
