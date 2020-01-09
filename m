From: Luca Ceresoli <luca@lucaceresoli.net>
Subject: Re: [PATCH v2] docs: i2c: Fix return value of i2c_smbus_xxx functions
Date: Thu, 9 Jan 2020 23:15:31 +0100
Message-ID: <0bf8bf55-525f-fd4e-0f10-fe0efad9ecb2@lucaceresoli.net>
References: <1574162632-65848-1-git-send-email-mine260309@gmail.com>
 <20191125144857.GA2412@kunai> <20191126115243.673fc164@endymion>
 <20200106130056.GA1290@ninjato> <20200109173929.1b42e0a6@endymion>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200109173929.1b42e0a6@endymion>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>, Wolfram Sang <wsa@the-dreams.de>
Cc: Lei YU <mine260309@gmail.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hi Jean,

On 09/01/20 17:39, Jean Delvare wrote:
> On Mon, 6 Jan 2020 14:01:09 +0100, Wolfram Sang wrote:
>>> I would go further and move half of the document to i2c-tools. i2c-dev
>>> itself only provides the ioctls. Everything on top of that is in libi2c
>>> now, so the kernel documentation should point to libi2c and the
>>> detailed documentation should come with libi2c.
>>>
>>> So I guess I should review the whole document now to see what needs to
>>> be updated, what should stay, and what should move.  
>>
>> Maybe you can collaborate with Luca on this who just revamped a lot of
>> the docs? Putting him on CC and marking this patch as 'Deferred'.
> 
> I'm resuming my work on this. Luca, can you point me to your changes to
> Documentation/i2c/dev-interface.rst so that I can adjust my own changes
> to fit on top?

Commits 4 and 26 of this series:

https://patchwork.ozlabs.org/project/linux-i2c/list/?series=151292

Pretty trivial patches anyway, I haven't really tackled that specific
file so far, which is good as you are planning to remove all/most of it.

-- 
Luca
