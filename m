From: David Daney <ddaney-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH] I2C: Add driver for Cavium OCTEON I2C ports.
Date: Tue, 02 Feb 2010 18:29:44 -0800
Message-ID: <4B68DF98.4080501@caviumnetworks.com>
References: <1264711627-24304-1-git-send-email-ddaney@caviumnetworks.com> <20100128234113.GC13143@linux-mips.org> <20100203022404.GB24325@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100203022404.GB24325-elnMNo+KYs3pIgCt6eIbzw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, rade.bozic.ext-OYasijW0DpE@public.gmane.org, Michael Lawnick <michael.lawnick.ext-OYasijW0DpE@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Ben Dooks wrote:
> On Fri, Jan 29, 2010 at 12:41:13AM +0100, Ralf Baechle wrote:
>> On Thu, Jan 28, 2010 at 12:47:07PM -0800, David Daney wrote:
>>
>> Thanks, I've replaced the queue patch with this one.
> 
> I'd rather avoid a cross-tree merge if possible. Is there anything
> stopping it being added to my next-i2c tree?
>  

I can't speak to the logistics, but I would note that there are two 
related MIPS specific patches that add the platform device and register 
some i2c_board_info.  I don't know if it would make sense to merge them 
all via the same path.

I will let you and Ralf decide that.

In any event thanks for looking at the patches,
David Daney



>>   Ralf
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
>> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
