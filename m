From: Barry Song <21cnbao@gmail.com>
Subject: Re: [PATCH] i2c: sirf: move driver init from module_init to
 subsys_initcall
Date: Thu, 16 May 2013 18:25:39 +0800
Message-ID: <CAGsJ_4zVOF8-g=emEGgP3atxkWdxMaQQiVZrZkht_WueTriSnw@mail.gmail.com>
References: <1368672607-5536-1-git-send-email-Baohua.Song@csr.com>
 <20130516093846.GA2927@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20130516093846.GA2927@katana>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: workgroup.linux@csr.com, Xiaomeng Hou <Xiaomeng.Hou@csr.com>, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Barry Song <Baohua.Song@csr.com>
List-Id: linux-i2c@vger.kernel.org

2013/5/16 Wolfram Sang <wsa@the-dreams.de>:
> On Thu, May 16, 2013 at 10:50:07AM +0800, Barry Song wrote:
>> From: Xiaomeng Hou <Xiaomeng.Hou@csr.com>
>>
>> if we initilize i2c bus by module_init, there are some devices which want
>> initialization earlier than i2c and could not do that in time, so move i2c
>> driver initilization to subsys_initcall and make i2c ready before devices
>> init.
>>
>> Signed-off-by: Xiaomeng Hou <Xiaomeng.Hou@csr.com>
>> Signed-off-by: Barry Song <Baohua.Song@csr.com>
>
> What about deferred probing?

deferred probing could work but could not work for automative.
what we really want is that devices begin to work as early as
possible. we want i2c clients like lcd, camera begin to show images as
early as possible as an automative requirement.

-barry
