From: "Justin P. Mattock" <justinmattock-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 4/8]drivers:tmp.c Fix warning: variable 'rc' set but	not
 used
Date: Mon, 14 Jun 2010 22:58:55 -0700
Message-ID: <4C17169F.4060205__49651.8244887286$1276581545$gmane$org@gmail.com>
References: <1276547208-26569-1-git-send-email-justinmattock@gmail.com> <1276547208-26569-5-git-send-email-justinmattock@gmail.com> <21331.1276560832@localhost> <4C16E18F.9050901@gmail.com> <9275.1276573789@localhost> <4C16F9FC.2080905@gmail.com> <20100615052944.7746.qmail@stuge.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100615052944.7746.qmail-Y+HMSxxDrH8@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Valdis.Kletnieks-PjAqaU27lzQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, reiserfs-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, debora-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.orglin
List-Id: linux-i2c@vger.kernel.org

On 06/14/2010 10:29 PM, Peter Stuge wrote:
> Justin P. Mattock wrote:
>>> *baffled* Why did you think that would work? transmit_cmd()s signature
>>> has 4 parameters.
>>
>> I have no manual in front of me. Did a quick google, but came up with
>> (no hits) info on what that function does. grep showed too many entries
>> to really see why/what this is.
>
> Check out the tool cscope. (Or kscope, if you prefer a GUI.)
>
>
> //Peter
>

thanks for this tool.. I think this is what I need.. running around not 
knowing what/where the manual is for a call is a bit daunting.
I'll give this a look.

Thanks for this..

Justin P. Mattock
