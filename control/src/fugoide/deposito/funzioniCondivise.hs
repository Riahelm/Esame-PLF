module AusFun where
    
    import Quadrupla
    import Coppia           
    import qualified DatiFugoide as DF
    import qualified CondizioniInizialiFugoide as CIF

    calcMoto :: a -> Float -> Int -> [Float]
    calcMoto dA@(dAA,_) dt len  | len < 0   = [dAA]
                                | len == 0  = [dBA]
                                | otherwise = dBA : calcolaProssimoPunto
                                where
                                    dB@(dBA,_)              = metodoEulero dA dt
                                    calcolaProssimoPunto    = calcMoto dB dt (len - 1)
    calcMoto dA@(_,_,_, dAD) dt | len < 0  = [dAD]
                                | len == 0 = [dBD]
                                | otherwise = dBD : calcolaProssimoPunto
                                where
                                    dB@(_,_,_, dBD)      = metodoEulero dA dt
                                    calcolaProssimoPunto = calcMoto dB dt (len - 1)
    
    metodoEulero :: a -> Float -> a
    metodoEulero dA dt = sommaCoppia dA (moltiplicaCoppiaPerScalare (rhs dA) dt)
    metodoEulero dA dt = sommaQuadrupla dA (moltiplicaQuadruplaPerScalare (rhs dA) dt)

    rhs :: a -> a
    rhs dA@(y@alt, v@vel)   = (v, cG * (1-y/yT))
        where
            cG              = DF.cG  -- Costante gravitazionale terrestre
            yT              = DF.yT -- Altitudine centrale all'oscillazione
    rhs dA@(v,theta,x,y) = (- (cG * sin theta) - (cR / cP)*cG/vTrim**2*v**2,
                            - (cG * cos theta / v) + cG/vTrim**2*v,
                            v*cos theta,
                            v*sin theta)
                            where
                                vTrim = DF.vTrim
                                cG = DF.cG   -- Costante gravitazionale terrestre
                                cR = 0.025  -- Coefficiente di resistenza all'aria
                                cP = 1.0    -- Coefficiente di portanza