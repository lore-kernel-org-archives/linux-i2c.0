From: "Justin P. Mattock" <justinmattock-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/8]reiserfs:stree.c Fix variable set but not used.
Date: Mon, 14 Jun 2010 14:09:58 -0700
Message-ID: <4C169AA6.6030809__30738.7079498314$1276549802$gmane$org@gmail.com>
References: <1276547208-26569-1-git-send-email-justinmattock@gmail.com> <1276547208-26569-2-git-send-email-justinmattock@gmail.com> <20100614204805.GA12589@elliptictech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100614204805.GA12589-7BP4RkwGw0uXmMXjJBpWqg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, reiserfs-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, clemens-P6GI/4k7KOmELgA04lAiVw@public.gmane.org, debora-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, linux-i2
List-Id: linux-i2c@vger.kernel.org

On 06/14/2010 01:48 PM, Nick Bowler wrote:
> On 13:26 Mon 14 Jun     , Justin P. Mattock wrote:
>> @@ -617,8 +616,7 @@ int search_by_key(struct super_block *sb, const struct cpu_key *key,	/* Key to s
>>
>>   	pathrelse(search_path);
>>
>> -	right_neighbor_of_leaf_node = 0;
>> -
>> +	
>
> This hunk introduces whitespace on the empty line, which is not cool.

I can resend!!(biggest problem is working
through these warnings)

>
>>   	/* With each iteration of this loop we search through the items in the
>>   	   current node, and calculate the next current node(next path element)
>>   	   for the next iteration of this loop.. */
>> @@ -695,8 +693,7 @@ int search_by_key(struct super_block *sb, const struct cpu_key *key,	/* Key to s
>>   			   starting from the root. */
>>   			block_number = SB_ROOT_BLOCK(sb);
>>   			expected_level = -1;
>> -			right_neighbor_of_leaf_node = 0;
>> -
>> +			
>
> Here, too.
>
> Most of the patches in this series have similar issues.
>

main thing now(for me atleast)is,
is this actual dead code or what?
if not then something else needs to
be done, if yes then I guess I can
resend this, with out the whitespace
issue.

Justin P. Mattock
