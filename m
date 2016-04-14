From: Jan Glauber <jan.glauber@caviumnetworks.com>
Subject: Re: [PATCH v6 06/19] i2c: octeon: Improve error status checking
Date: Thu, 14 Apr 2016 10:10:05 +0200
Message-ID: <20160414081005.GC2532@hardcore>
References: <cover.1460387640.git.jglauber@cavium.com>
 <dded382de33f6a4b64c87d8ca2e016871403784d.1460387640.git.jglauber@cavium.com>
 <20160413085519.GF1563@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-bn1on0095.outbound.protection.outlook.com ([157.56.110.95]:27889
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751742AbcDNIKW (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Thu, 14 Apr 2016 04:10:22 -0400
Content-Disposition: inline
In-Reply-To: <20160413085519.GF1563@katana>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, David Daney <ddaney@caviumnetworks.com>

On Wed, Apr 13, 2016 at 10:55:20AM +0200, Wolfram Sang wrote:
> 
> Please have a look at Documentation/i2c/fault-codes. -EAGAIN is only for
> arbitration loss.
> 
> > +	/* ACK allowed on pre-terminal bytes only */
> > +	case STAT_RXDATA_ACK:
> > +		if (!final_read)
> > +			return 0;
> > +		return -EAGAIN;
> > +
> > +	/* NAK allowed on terminal byte only */
> > +	case STAT_RXDATA_NAK:
> > +		if (final_read)
> > +			return 0;
> > +		return -EAGAIN;
> 
> -EIO? Can this happen? It is the master who sends the NAK, so we are in
> control of that.

If it happens not in the final_read part then it is an error, so -EIO 
would be better suited. Also for the other error codes I will follow your
suggestion.

Should I resend the whole series or will you review the other patches
before?

Thanks,
Jan

> > +
> > +	/* Arbitration lost */
> > +	case STAT_LOST_ARB_38:
> > +	case STAT_LOST_ARB_68:
> > +	case STAT_LOST_ARB_78:
> > +	case STAT_LOST_ARB_B0:
> > +		return -EAGAIN;
> 
> OK.
> 
> > +
> > +	/* Being addressed as slave, should back off & listen */
> > +	case STAT_SLAVE_60:
> > +	case STAT_SLAVE_70:
> > +	case STAT_GENDATA_ACK:
> > +	case STAT_GENDATA_NAK:
> > +		return -EIO;
> 
> -EOPNOTSUPP?
> 
> > +
> > +	/* Core busy as slave */
> > +	case STAT_SLAVE_80:
> > +	case STAT_SLAVE_88:
> > +	case STAT_SLAVE_A0:
> > +	case STAT_SLAVE_A8:
> > +	case STAT_SLAVE_LOST:
> > +	case STAT_SLAVE_NAK:
> > +	case STAT_SLAVE_ACK:
> > +		return -EIO;
> 
> -EOPNOTSUPP?
> 
> > +	case STAT_TXDATA_NAK:
> 
> -EIO?
> 
> > +	case STAT_TXADDR_NAK:
> > +	case STAT_RXADDR_NAK:
> > +	case STAT_AD2W_NAK:
> 
> -ENXIO?
> 
> > +		return -EAGAIN;
> > +	default:
> > +		dev_err(i2c->dev, "unhandled state: %d\n", stat);
> > +		return -EIO;
> 
> OK.
> 
