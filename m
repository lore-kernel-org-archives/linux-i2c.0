From: Shubhrajyoti Datta <shubhrajyoti.datta@gmail.com>
Subject: Re: [PATCH] Further cadence i2c buffer overrun fixes
Date: Tue, 17 Dec 2019 11:11:31 +0530
Message-ID: <CAKfKVtFmGmef1AwK9XKccZDP0f+gCjNfmAhFpPcCObeuKvbU+w@mail.gmail.com>
References: <20180416012248.25891-1-amworsley@gmail.com>
 <20180416012248.25891-2-amworsley@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180416012248.25891-2-amworsley@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Andrew Worsley <amworsley@gmail.com>
Cc: linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, harinik@xilinx.com, APANDEY@xilinx.com, asarkar@xilinx.com, linux-i2c <linux-i2c@vger.kernel.org>, =?UTF-8?Q?S=C3=B6ren_Brinkmann?= <soren.brinkmann@xilinx.com>
List-Id: linux-i2c@vger.kernel.org

Hi Andrew,

On Mon, Apr 16, 2018 at 6:55 AM Andrew Worsley <amworsley@gmail.com> wrote:
>
> After this set of changes ran over 2 days 17 hours with no i2c failures
> at 200kHz.
Can you explain this speed why you need it.
why not the standard ones.

>  Previously would lock up with BA (Bus Active) bit set
> continously with in a few hours
>
