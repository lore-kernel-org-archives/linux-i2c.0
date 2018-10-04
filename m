From: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Subject: Re: [PATCH i2c-next v5 4/5] i2c: aspeed: Remove hard-coded bus
 timeout value setting
Date: Thu, 4 Oct 2018 09:11:47 -0700
Message-ID: <185b73f1-ad5f-eedb-7c56-2a2e266f5960@linux.intel.com>
References: <20181003223107.16133-1-jae.hyun.yoo@linux.intel.com>
 <20181003223107.16133-5-jae.hyun.yoo@linux.intel.com>
 <CACPK8XdTMfdw1Tu97oD7R7MXQKGHnA5A+SVfAA3RDkiTd_bawA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CACPK8XdTMfdw1Tu97oD7R7MXQKGHnA5A+SVfAA3RDkiTd_bawA@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Joel Stanley <joel@jms.id.au>
Cc: Brendan Higgins <brendanhiggins@google.com>, Wolfram Sang <wsa@the-dreams.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Andrew Jeffery <andrew@aj.id.au>, linux-i2c@vger.kernel.org, OpenBMC Maillist <openbmc@lists.ozlabs.org>, devicetree <devicetree@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-aspeed@lists.ozlabs.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, jarkko.nikula@linux.intel.com, James Feist <james.feist@linux.intel.com>, Vernon Mauery <vernon.mauery@linux.intel.com>
List-Id: linux-i2c@vger.kernel.org

On 10/4/2018 1:32 AM, Joel Stanley wrote:
> On Thu, 4 Oct 2018 at 00:31, Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com> wrote:
>>
>> This commit removes hard-coded bus timeout value setting so that
>> it can be set by i2c-core-base.
>>
>> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
> 
> Reviewed-by: Joel Stanley <joel@jms.id.au>
> 

Thanks for the review, Joel!
