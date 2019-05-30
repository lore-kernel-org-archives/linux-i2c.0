From: Eduardo Valentin <eduval@amazon.com>
Subject: Re: [PATCH i2c/slave-mqueue v5] i2c: slave-mqueue: add a slave
 backend to receive and queue messages
Date: Wed, 29 May 2019 21:02:17 -0700
Message-ID: <20190530040217.GB17772@u40b0340c692b58f6553c.ant.amazon.com>
References: <1524503192-4176-1-git-send-email-haiyue.wang@linux.intel.com>
 <20190523220345.GA3417@u40b0340c692b58f6553c.ant.amazon.com>
 <35a9d066-c732-cb00-04a5-438c948915ae@linux.intel.com>
 <20190524173353.GA6428@u40b0340c692b58f6553c.ant.amazon.com>
 <bf1e8f0b-5bd0-fb43-c19b-9487603b9ee3@linux.intel.com>
 <20190529231100.GA18339@u40b0340c692b58f6553c.ant.amazon.com>
 <75cb9514-bb3a-9c3b-05df-0c3517bd775a@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <75cb9514-bb3a-9c3b-05df-0c3517bd775a@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Wang, Haiyue" <haiyue.wang@linux.intel.com>
Cc: Eduardo Valentin <eduval@amazon.com>, wsa@the-dreams.de, brendanhiggins@google.com, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org, jarkko.nikula@linux.intel.com, andriy.shevchenko@intel.com, jae.hyun.yoo@linux.intel.com
List-Id: linux-i2c@vger.kernel.org

On Thu, May 30, 2019 at 09:33:34AM +0800, Wang, Haiyue wrote:
> 
> 在 2019-05-30 07:11, Eduardo Valentin 写道:
> >>>>>>+
> >>>>>>+	case I2C_SLAVE_WRITE_RECEIVED:
> >>>>>>+		if (msg->len < MQ_MSGBUF_SIZE) {
> >>>>>>+			msg->buf[msg->len++] = *val;
> >>>>>Do we need to lock the accesses to msg->buf? how about to msg->len?
> >>>this code goes access and modify data here, e.g. msg->len and msg->buf.
> >>>
> >>>On this case (I2C_SLAVE_WRITE_RECEIVED), this code wont protect access.
> >>>
> >>>This can cause concurrence issues if you receive an IRQ when the user
> >>>is on your bin_read().
> >>User will not touch 'msg = mq->curr;', just touch 'msg =
> >>&mq->queue[mq->out];'
> >What happens if mq->curr == mq->queue[mq->out]?
> >
> 1. The Read will check.
> 
> +	spin_lock_irqsave(&mq->lock, flags);
> +	if (mq->out != mq->in) {
> +		msg = &mq->queue[mq->out];
> 
> 2. Flush the oldeast message. ^_^
> 
> +	case I2C_SLAVE_STOP:
> +		if (unlikely(mq->truncated || msg->len < 2))
> +			break;
> +
> +		spin_lock(&mq->lock);
> +		mq->in = MQ_QUEUE_NEXT(mq->in);
> +		mq->curr = &mq->queue[mq->in];
> +		mq->curr->len = 0;
> +
> +		/* Flush the oldest message */
> +		if (mq->out == mq->in)
> +			mq->out = MQ_QUEUE_NEXT(mq->out);

Yeah, I see. We keep on dropping messages (old ones) when the queue is full...

> +		spin_unlock(&mq->lock);
> 

-- 
All the best,
Eduardo Valentin
