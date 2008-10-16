From: "Grant Likely" <grant.likely@secretlab.ca>
Subject: Re: [PATCH 1/7] powerpc and sparc: introduce dev_archdata node
	accessors
Date: Thu, 16 Oct 2008 17:02:54 -0600
Message-ID: <fa686aa40810161602v16232d96g2eb9af5c063f24f0@mail.gmail.com>
References: <20081016171222.GA24812@oksana.dev.rtsoft.ru>
	<20081016171251.GA5515@oksana.dev.rtsoft.ru>
	<20081016.153641.32547403.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org>
In-Reply-To: <20081016.153641.32547403.davem@davemloft.net>
Content-Disposition: inline
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
Errors-To: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
To: David Miller <davem@davemloft.net>
Cc: dbrownell@users.sourceforge.net, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, i2c@lm-sensors.org, khali@linux-fr.org
List-Id: linux-i2c@vger.kernel.org

On Thu, Oct 16, 2008 at 4:36 PM, David Miller <davem@davemloft.net> wrote:
> From: Anton Vorontsov <avorontsov@ru.mvista.com>
> Date: Thu, 16 Oct 2008 21:12:51 +0400
>
>> The name of the device_node field differ across the platforms, so we
>> have to implement inlined accessors. This is needed to avoid ugly
>> #ifdef in the generic code.
>>
>> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
>
> I'm happy to just change this member name on sparc to match
> powerpc's choice.
>
> That being said, this abstraction still has value and I'd
> like to let you merge this now and make forward progress
> so:
>
> Acked-by: David S. Miller <davem@davemloft.net>

I agree;

Acked-by: Grant Likely <grant.likely@secretlab.ca>



-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
