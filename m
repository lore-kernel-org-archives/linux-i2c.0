From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH v2] Revert "i2c: rcar: remove spinlock"
Date: Sun, 24 Aug 2014 15:30:47 +0400
Message-ID: <53F9CCE7.3010006@cogentembedded.com>
References: <1642788.pEhrsPDp4u@wasted.cogentembedded.com> <20140824064520.GA2578@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20140824064520.GA2578@katana>
Sender: linux-sh-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-sh@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hello.

On 8/24/2014 10:45 AM, Wolfram Sang wrote:

>> This reverts commit 150b8be3cda54412ad7b54f5392b513b25c0aaa7.

>> The I2C core's per-adapter locks can't protect from IRQs, so the driver still
>> needs a spinlock to protect the register accesses.

> Looks to me like a plain revert. What about the issues you mentioned?
> Don't you want to fix them? Confused...

    You told me to do 2 patches, one of them just revert. Here you are. As for 
the follow up patch, I need to think a bit more, so all in a good time.

WBR, Sergei

